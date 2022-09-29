# Argo CD
---

<img src="https://cncf-branding.netlify.app/img/projects/argo/horizontal/color/argo-horizontal-color.png" alt="argocd-logo" width="400" height="200" alt="helm-logo" />

Declarative continuous deployment for Kubernetes

## Resources
---
- [ ] [github/argo-cd](https://github.com/argoproj/argo-cd)
- [ ] [argo-cd.readthedocs.io](https://argo-cd.readthedocs.io/en/stable/)
- [ ] [Git Generator - argocd-applicationset](https://argocd-applicationset.readthedocs.io/en/stable/Generators-Git/)
- [ ] [Git Generator - argo-cd](https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/Generators-Git/)

## Description
---
Argo CD is one of the top GitOps continues delivery tools for Kubernetes in Cloud Native ecosystem nowadays.

Argo CD  implements GitOps Pull Model where it track any changes in source repos and sync/deploy the changes automatically into the destination clusters.

## Why Argo CD
---
Application definitions, configurations, and environments should be declarative and version controlled. Application deployment and lifecycle management should be automated, auditable, and easy to understand.

## Topics
---
- CD workflow without ArgoCD
- CD workflow with ArgoCD
- Benefits of using GitOps with ArgoCD
- Git as a Single Source of Truth
- Easy Rollback
- Cluster Disaster Recovery
- k8s Access Control with Git and ArgoCD
- ArgoCD as k8s Extension
- How to configure ArgoCD
- Multiple Clusters with ArgoCD
- Replacement with other CI-CD tools
- Practice Argo CD CLI
- Generate applications using Argo CD application-set
- Create and manage applications using Argo CD declarativity and using UI
- Explore and practice Argo CD syncing options, waves and phases
- How to integrate with CI systems
- Git as the source of truth for your applications.
- Developer and DevOps engineer will update the Git code only.
- It will keep your Kubernetes destination clusters in sync with Git.
- we can achieve easy rollback.
- More security : Grant access to  Kubernetes cluster to ArgoCD only and avoid granting CI systems or humans.
- Disaster recovery solution : You easily deploy the same applications to any  Kubernetes cluster.
