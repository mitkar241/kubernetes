# LogIn
---
```bash
argocd login localhost:8080
```
```
WARNING: server certificate had error: x509: certificate signed by unknown authority. Proceed insecurely (y/n)? y
Username: admin
Password: 
'admin:login' logged in successfully
Context 'localhost:8080' updated
```

If not logged in, this type of error will pop up

```
~$ argocd app list
FATA[0000] rpc error: code = Unauthenticated desc = invalid session: Token is expired
```
