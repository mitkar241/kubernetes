# Resource Short Names
---

| Resource  | Short Name  |
| --- | --- |
|	certificaterequests	|	cr, crs	|
|	certificates	|	cert, certs	|
|	certificatesigningrequests	|	csr	|
|	componentstatuses	|	cs	|
|	configmaps	|	cm	|
|	cronjobs	|	cj	|
|	customresourcedefinitions	|	crd, crds	|
|	daemonsets	|	ds	|
|	deployments	|	deploy	|
|	endpoints	|	ep	|
|	events	|	ev	|
|	horizontalpodautoscalers	|	hpa	|
|	ingresses	|	ing	|
|	limitranges	|	limits	|
|	namespaces	|	ns	|
|	networkpolicies	|	netpol	|
|	nodes	|	no	|
|	persistentvolumeclaims	|	pvc	|
|	persistentvolumes	|	pv	|
|	pods	|	po	|
|	poddisruptionbudgets	|	pdb	|
|	podsecuritypolicies	|	psp	|
|	priorityclasses	|	pc	|
|	replicasets	|	rs	|
|	replicationcontrollers	|	rc	|
|	resourcequotas	|	quota	|
|	scheduledscalers	|	ss	|
|	serviceaccounts	|	sa	|
|	services	|	svc	|
|	statefulsets	|	sts	|
|	storageclasses	|	sc	|

## Hands-on
---
```
$ kubectl describe
You must specify the type of resource to describe. Valid resource types include:
    * all
    * certificatesigningrequests (aka 'csr')
    * clusters (valid only for federation apiservers)
    * clusterrolebindings
    * clusterroles
    * componentstatuses (aka 'cs')
    * configmaps (aka 'cm')
    * daemonsets (aka 'ds')
    * deployments (aka 'deploy')
    * endpoints (aka 'ep')
    * events (aka 'ev')
    * horizontalpodautoscalers (aka 'hpa')
    * ingresses (aka 'ing')
    * jobs
    * limitranges (aka 'limits')
    * namespaces (aka 'ns')
    * networkpolicies
    * nodes (aka 'no')
    * persistentvolumeclaims (aka 'pvc')
    * persistentvolumes (aka 'pv')
    * pods (aka 'po')
    * poddisruptionbudgets (aka 'pdb')
    * podsecuritypolicies (aka 'psp')
    * podtemplates
    * replicasets (aka 'rs')
    * replicationcontrollers (aka 'rc')
    * resourcequotas (aka 'quota')
    * rolebindings
    * roles
    * secrets
    * serviceaccounts (aka 'sa')
    * services (aka 'svc')
    * statefulsets
    * storageclasses
    * thirdpartyresources
```

```
[root@hsk-controller ~]# kubectl api-resources
NAME                              SHORTNAMES       KIND
bindings                                           Binding
componentstatuses                 cs               ComponentStatus
configmaps                        cm               ConfigMap
endpoints                         ep               Endpoints
events                            ev               Event
limitranges                       limits           LimitRange
namespaces                        ns               Namespace
nodes                             no               Node
persistentvolumeclaims            pvc              PersistentVolumeClaim
persistentvolumes                 pv               PersistentVolume
pods                              po               Pod
podtemplates                                       PodTemplate
replicationcontrollers            rc               ReplicationController
resourcequotas                    quota            ResourceQuota
secrets                                            Secret
serviceaccounts                   sa               ServiceAccount
services                          svc              Service
initializerconfigurations                          InitializerConfiguration
mutatingwebhookconfigurations                      MutatingWebhookConfiguration
validatingwebhookconfigurations                    ValidatingWebhookConfiguration
customresourcedefinitions         crd,crds         CustomResourceDefinition
apiservices                                        APIService
controllerrevisions                                ControllerRevision
daemonsets                        ds               DaemonSet
deployments                       deploy           Deployment
replicasets                       rs               ReplicaSet
statefulsets                      sts              StatefulSet
tokenreviews                                       TokenReview
localsubjectaccessreviews                          LocalSubjectAccessReview
selfsubjectaccessreviews                           SelfSubjectAccessReview
selfsubjectrulesreviews                            SelfSubjectRulesReview
subjectaccessreviews                               SubjectAccessReview
horizontalpodautoscalers          hpa              HorizontalPodAutoscaler
cronjobs                          cj               CronJob
jobs                                               Job
brpolices                         br,bp            BrPolicy
clusters                          rcc              Cluster
filesystems                       rcfs             Filesystem
objectstores                      rco              ObjectStore
pools                             rcp              Pool
certificatesigningrequests        csr              CertificateSigningRequest
leases                                             Lease
events                            ev               Event
daemonsets                        ds               DaemonSet
deployments                       deploy           Deployment
ingresses                         ing              Ingress
networkpolicies                   netpol           NetworkPolicy
podsecuritypolicies               psp              PodSecurityPolicy
replicasets                       rs               ReplicaSet
nodes                                              NodeMetrics
pods                                               PodMetrics
networkpolicies                   netpol           NetworkPolicy
poddisruptionbudgets              pdb              PodDisruptionBudget
podsecuritypolicies               psp              PodSecurityPolicy
clusterrolebindings                                ClusterRoleBinding
clusterroles                                       ClusterRole
rolebindings                                       RoleBinding
roles                                              Role
volumes                           rv               Volume
priorityclasses                   pc               PriorityClass
storageclasses                    sc               StorageClass
volumeattachments                                  VolumeAttachment
```
