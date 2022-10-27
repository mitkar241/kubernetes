# List App
---
```bash
argocd app list
```
```
NAME                    CLUSTER                         NAMESPACE  PROJECT  STATUS   HEALTH   SYNCPOLICY  CONDITIONS       REPO                                              PATH  TARGET
myapp-argo-application  https://kubernetes.default.svc  myapp      default  Unknown  Healthy  Auto-Prune  ComparisonError  https://gitlab.com/nanuchi/argocd-app-config.git  dev   HEAD
```
