#!/bin/sh -eu

addSambaUser() {
	local username="$1"
	local password="$2"

	adduser -s /sbin/nologin -h /home/samba -H -D "$username"
	
	echo -e "$password\n$password" | smbpasswd -s -a "$username"
}

addSambaUser "joonas" "$JOONAS_PASSWORD"

# for security, let's unset the ENV var containing secrets
unset "JOONAS_PASSWORD"

# for --no-process-group see https://stackoverflow.com/questions/49357524/docker-alpine-samba-does-not-start
exec smbd --foreground --no-process-group --log-stdout