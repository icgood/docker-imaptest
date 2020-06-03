docker-imaptest
===============

Docker image for running imaptest against an IMAP server.

https://imapwiki.org/ImapTest/

## Usage

```bash
docker run -it icgood/imaptest \
    host=imap.example.com user=user@example.com pass=abc123
```
