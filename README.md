[![Build Status](https://img.shields.io/travis/joonas-fi/samba.svg?style=for-the-badge)](https://travis-ci.org/joonas-fi/samba)
[![Download](https://img.shields.io/docker/pulls/joonas/samba.svg?style=for-the-badge)](https://hub.docker.com/r/joonas/samba/)

Samba, contained - as all things should be.


Status
------

Might be ready for public consumption, but don't expect much support if you encounter problems.


Use case
--------

We only support this use case:

The container automatically shares all directories from `/samba-private` to your named user only.
Only one username/password is supported.

`/samba-public` is writable to guest users (e.g. your family).


Running
-------

Example:

```
$ docker run --rm -it -p 445:445 \
	-e "SMB_USERNAME=joonas" \
	-e "SMB_PASSWORD=..." \
	-v "/home/joonas/music:/samba-private/music" \
	-v "/home/joonas/movies:/samba-private/movies" \
	-v "/home/joonas/family-public:/samba-public" \
	joonas/samba
```


Thanks
------

Standing on the shoulders of giants:

- Strongly inspired by [Stanback/alpine-samba](https://github.com/Stanback/alpine-samba)
