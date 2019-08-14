[![Build Status](https://img.shields.io/travis/joonas-fi/samba.svg?style=for-the-badge)](https://travis-ci.org/joonas-fi/samba)
[![Download](https://img.shields.io/docker/pulls/joonas/samba.svg?style=for-the-badge)](https://hub.docker.com/r/joonas/samba/)

Samba, contained - as all things should be.


Status
------

Not ready for public consumption (yet?).


Running
-------

Example:

```
$ docker run --rm -it -p 445:445 \
	-e "JOONAS_PASSWORD=..." \
	-v "/samba/joonas:/samba/joonas" \
	-v "/samba/public:/samba/public" \
	joonas/samba
```


Thanks
------

Standing on the shoulders of giants:

- Strongly inspired by [Stanback/alpine-samba](https://github.com/Stanback/alpine-samba)
