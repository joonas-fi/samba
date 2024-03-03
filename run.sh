#!/bin/sh -eu

# thanks https://serverfault.com/a/649619
addSambaShare() {
	local shareName="$1"
	local path="$2"

	# [joonas]
	#   path = /samba-private/joonas
	#   browseable = yes
	#   read only = no
	#   valid users = joonas
	echo -e "[$shareName]\n  path = $path\n  browseable = yes\n  read only = no\n  valid users = $SMB_USERNAME\n" > "/etc/samba/smb.d/$shareName.conf"

	echo "include = /etc/samba/smb.d/$shareName.conf" >> /etc/samba/includes.conf
}

addSambaUser() {
	local username="$1"
	local password="$2"

	adduser -s /sbin/nologin -h /home/samba -H -D "$username"
	
	echo -e "$password\n$password" | smbpasswd -s -a "$username"
}

setupDoneFlagFile="/setup_done"

# do this only once so that if the container is restarted, we don't try to do this twice.
if [ ! -f "$setupDoneFlagFile" ]; then
	mkdir -p /etc/samba/smb.d
	echo "" > /etc/samba/includes.conf

	addSambaUser "$SMB_USERNAME" "$SMB_PASSWORD"

	directories=/samba-private/*
	for directory in $directories
	do
		# "/samba-private/foobar" => "foobar"
		shareName=$(basename "$directory")

		addSambaShare "$shareName" "$directory"
	done

	touch "$setupDoneFlagFile"
fi

# for security, let's unset the ENV var containing secrets
unset "SMB_PASSWORD"

# for --no-process-group see https://stackoverflow.com/questions/49357524/docker-alpine-samba-does-not-start
exec smbd --foreground --no-process-group --debug-stdout
