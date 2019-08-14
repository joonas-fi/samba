FROM alpine:latest

ENTRYPOINT ["/run.sh"]

RUN apk add --update \
	samba-common-tools \
	samba-client \
	samba-server \
	&& rm -rf /var/cache/apk/*

ADD smb.conf /etc/samba/smb.conf
ADD run.sh /run.sh
