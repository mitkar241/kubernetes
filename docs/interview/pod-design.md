# Pod Design
---
Practice questions based on these concepts
- Understand how to use Labels, Selectors and Annotations
- Understand Deployments and how to perform rolling updates
- Understand Deployments and how to perform rollbacks
- Understand Jobs and CronJobs

---

Get the pods with label information

<details><summary></summary>

```bash
kubectl get pods --show-labels
```

</details>

---

Create 5 nginx pods in which two of them is labeled env=prod and three of them is labeled env=dev

<details><summary></summary>

```bash
kubectl run nginx-dev1 --image=nginx --restart=Never --labels=env=dev
kubectl run nginx-dev2 --image=nginx --restart=Never --labels=env=dev
kubectl run nginx-dev3 --image=nginx --restart=Never --labels=env=dev

kubectl run nginx-prod1 --image=nginx --restart=Never --labels=env=prod
kubectl run nginx-prod2 --image=nginx --restart=Never --labels=env=prod
```

</details>

---

Verify all the pods are created with correct labels

<details><summary></summary>

```bash
kubectl get pods --show-labels
```

</details>

---

Get the pods with label env=dev

<details><summary></summary>

```bash
kubectl get pods -l env=dev
```

</details>

---

Get the pods with label env=dev and also output the labels

<details><summary></summary>

```bash
kubectl get pods -l env=dev --show-labels
```

</details>

---

Get the pods with label env=prod

<details><summary></summary>

```bash
kubectl get pods -l env=prod
```

</details>

---

Get the pods with label env=prod and also output the labels

<details><summary></summary>

```bash
kubectl get pods -l env=prod --show-labels
```

</details>

---

Get the pods with label env

<details><summary></summary>

```bash
kubectl get pods -L env
```

</details>

---

Get the pods with labels env=dev and env=prod

<details><summary></summary>

```bash
kubectl get pods -l 'env in (dev,prod)'
```

</details>

---

Get the pods with labels env=dev and env=prod and output the labels as well

<details><summary></summary>

```bash
kubectl get pods -l 'env in (dev,prod)' --show-labels
```

</details>

---

Change the label for one of the pod to env=uat and list all the pods to verify

<details><summary></summary>

```bash
kubectl label pod/nginx-dev3 env=uat --overwrite
kubectl get pods --show-labels
```

</details>

---

Remove the labels for the pods that we created now and verify all the labels are removed

<details><summary></summary>

```bash
kubectl label pod nginx-dev{1..3} env-
kubectl label pod nginx-prod{1..2} env-

kubectl get po --show-labels
```

</details>

---

Let’s add the label app=nginx for all the pods and verify

<details><summary></summary>

```bash
kubectl label pod nginx-dev{1..3} app=nginx
kubectl label pod nginx-prod{1..2} app=nginx

kubectl get po --show-labels
```

</details>

---

Get all the nodes with labels (if using minikube you would get only master node)

<details><summary></summary>

```bash
kubectl get nodes --show-labels
```

</details>

---

Label the node (minikube if you are using) nodeName=nginxnode

<details><summary></summary>

```bash
kubectl label node minikube nodeName=nginxnode
```

</details>

---

Create a Pod that will be deployed on this node with the label nodeName=nginxnode

<details><summary></summary>

```bash
kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml > pod.yaml
```

add the nodeSelector like below and create the pod
```bash
kubectl create -f pod.yaml
```

`pod.yaml`
```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  nodeSelector:
    nodeName: nginxnode
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}
```

</details>

---

Verify the pod that it is scheduled with the node selector

<details><summary></summary>

```bash
kubectl describe po nginx | grep Node-Selectors
```

</details>

---

Verify the pod nginx that we just created has this label

<details><summary></summary>

```bash
kubectl describe po nginx | grep Labels
```

</details>

---

Annotate the pods with name=webapp

<details><summary></summary>

```bash
kubectl annotate pod nginx-dev{1..3} name=webapp
kubectl annotate pod nginx-prod{1..2} name=webapp
```

</details>

---

Verify the pods that have been annotated correctly

<details><summary></summary>

```bash
kubectl describe po nginx-dev{1..3} | grep -i annotations
kubectl describe po nginx-prod{1..2} | grep -i annotations
```

</details>

---

Remove the annotations on the pods and verify

<details><summary></summary>

```bash
kubectl annotate pod nginx-dev{1..3} name-
kubectl annotate pod nginx-prod{1..2} name-

kubectl describe po nginx-dev{1..3} | grep -i annotations
kubectl describe po nginx-prod{1..2} | grep -i annotations
```

</details>

---

Remove all the pods that we created so far

<details><summary></summary>

```bash
kubectl delete po --all
```

</details>

---

Create a deployment called webapp with image nginx with 5 replicas

<details><summary></summary>

```bash
kubectl create deploy webapp --image=nginx --dry-run -o yaml > webapp.yaml
```

change the replicas to 5 in the yaml and create it
```bash
kubectl create -f webapp.yaml
```

`webapp.yaml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: webapp
  name: webapp
spec:
  replicas: 5
  selector:
    matchLabels:
      app: webapp
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: webapp
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
status: {}
```

</details>

---

Get the deployment you just created with labels

<details><summary></summary>

```bash
kubectl get deploy webapp --show-labels
```

</details>

---

Output the yaml file of the deployment you just created

<details><summary></summary>

```bash
kubectl get deploy webapp -o yaml
```

</details>

---

Get the pods of this deployment

<details><summary></summary>

get the label of the deployment
```bash
kubectl get deploy --show-labels
```

get the pods with that label
```bash
kubectl get pods -l app=webapp
```

</details>

---

Scale the deployment from 5 replicas to 20 replicas and verify

<details><summary></summary>

```bash
kubectl scale deploy webapp --replicas=20
kubectl get po -l app=webapp
```

</details>

---

Get the deployment rollout status

<details><summary></summary>

```bash
kubectl rollout status deploy webapp
```

</details>

---

Get the replicaset that created with this deployment

<details><summary></summary>

```bash
kubectl get rs -l app=webapp
```

</details>

---

Get the yaml of the replicaset and pods of this deployment

<details><summary></summary>

```bash
kubectl get rs -l app=webapp -o yaml
kubectl get po -l app=webapp -o yaml
```

</details>

---

Delete the deployment you just created and watch all the pods are also being deleted

<details><summary></summary>

```bash
kubectl delete deploy webapp
kubectl get po -l app=webapp -w
```

</details>

---

Create a deployment of webapp with image nginx:1.17.1 with container port 80 and verify the image version

<details><summary></summary>

```bash
kubectl create deploy webapp --image=nginx:1.17.1 --dry-run -o yaml > webapp.yaml
```

add the port section and create the deployment
```bash
kubectl create -f webapp.yaml
#verify
kubectl describe deploy webapp | grep Image
```

`webapp.yaml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: webapp
  name: webapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webapp
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: webapp
    spec:
      containers:
      - image: nginx:1.17.1
        name: nginx
        ports:
        - containerPort: 80
        resources: {}
status: {}
```

</details>

---

Update the deployment with the image version 1.17.4 and verify

<details><summary></summary>

```bash
kubectl set image deploy/webapp nginx=nginx:1.17.4
kubectl describe deploy webapp | grep Image
```

</details>

---

Check the rollout history and make sure everything is ok after the update

<details><summary></summary>

```bash
kubectl rollout history deploy webapp

kubectl get deploy webapp --show-labels
kubectl get rs -l app=webapp
kubectl get po -l app=webapp
```

</details>

---

Undo the deployment to the previous version 1.17.1 and verify Image has the previous version

<details><summary></summary>

```bash
kubectl rollout undo deploy webapp
kubectl describe deploy webapp | grep Image
```

</details>

---

Update the deployment with the image version 1.16.1 and verify the image and also check the rollout history

<details><summary></summary>

```bash
kubectl set image deploy/webapp nginx=nginx:1.16.1
kubectl describe deploy webapp | grep Image
kubectl rollout history deploy webapp
```

</details>

---

Update the deployment to the Image 1.17.1 and verify everything is ok

<details><summary></summary>

```bash
kubectl rollout undo deploy webapp --to-revision=3
kubectl describe deploy webapp | grep Image
kubectl rollout status deploy webapp
```

</details>

---

Update the deployment with the wrong image version 1.100 and verify something is wrong with the deployment

<details><summary></summary>

```bash
kubectl set image deploy/webapp nginx=nginx:1.100
kubectl rollout status deploy webapp (still pending state)
kubectl get pods
#ImagePullErr
```

</details>

---

Undo the deployment with the previous version and verify everything is Ok

<details><summary></summary>

```bash
kubectl rollout undo deploy webapp
kubectl rollout status deploy webapp
kubectl get pods
```

</details>

---

Check the history of the specific revision of that deployment

<details><summary></summary>

```bash
kubectl rollout history deploy webapp --revision=7
```

</details>

---

Pause the rollout of the deployment

<details><summary></summary>

```bash
kubectl rollout pause deploy webapp
```

</details>

---

Update the deployment with the image version latest and check the history and verify nothing is going on

<details><summary></summary>

```bash
kubectl set image deploy/webapp nginx=nginx:latest
kubectl rollout history deploy webapp
#No new revision
```

</details>

---

Resume the rollout of the deployment

<details><summary></summary>

```bash
kubectl rollout resume deploy webapp
```

</details>

---

Check the rollout history and verify it has the new version

<details><summary></summary>

```bash
kubectl rollout history deploy webapp
kubectl rollout history deploy webapp --revision=9
```

</details>

---

Apply the autoscaling to this deployment with minimum 10 and maximum 20 replicas and target CPU of 85% and verify hpa is created and replicas are increased to 10 from 1

<details><summary></summary>

```bash
kubectl autoscale deploy webapp --min=10 --max=20 --cpu-percent=85
kubectl get hpa
kubectl get pod -l app=webapp
```

</details>

---

Clean the cluster by deleting deployment and hpa you just created

<details><summary></summary>

```bash
kubectl delete deploy webapp
kubectl delete hpa webapp
```

</details>

---

Create a Job with an image node which prints node version and also verifies there is a pod created for this job

<details><summary></summary>

```bash
kubectl create job nodeversion --image=node -- node -v

kubectl get job -w
kubectl get pod
```

</details>

---

Get the logs of the job just created

<details><summary></summary>

```bash
kubectl logs <pod name>
#created from the job
```

</details>

---

Output the yaml file for the Job with the image busybox which echos “Hello I am from job”

<details><summary></summary>

```bash
kubectl create job hello-job --image=busybox --dry-run -o yaml -- echo "Hello I am from job"
```

</details>

---

Copy the above YAML file to hello-job.yaml file and create the job

<details><summary></summary>

```bash
kubectl create job hello-job --image=busybox --dry-run -o yaml -- echo "Hello I am from job" > hello-job.yaml
kubectl create -f hello-job.yaml
```

</details>

---

Verify the job and the associated pod is created and check the logs as well

<details><summary></summary>

```bash
kubectl get job
kubectl get po

kubectl logs hello-job-*
```

</details>

---

Delete the job we just created

<details><summary></summary>

```bash
kubectl delete job hello-job
```

</details>

---

Create the same job and make it run 10 times one after one

<details><summary></summary>

```bash
kubectl create job hello-job --image=busybox --dry-run -o yaml -- echo "Hello I am from job" > hello-job.yaml
```

edit the yaml file to add completions: 10
```bash
kubectl create -f hello-job.yaml
```

`hello-job.yaml`
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  creationTimestamp: null
  name: hello-job
spec:
  completions: 10
  template:
    metadata:
      creationTimestamp: null
    spec:
      containers:
      - command:
        - echo
        - Hello I am from job
        image: busybox
        name: hello-job
        resources: {}
      restartPolicy: Never
status: {}
```

</details>

---

Watch the job that runs 10 times one by one and verify 10 pods are created and delete those after it’s completed

<details><summary></summary>

```bash
kubectl get job -w
kubectl get po

kubectl delete job hello-job
```

</details>

---

Create the same job and make it run 10 times parallel

<details><summary></summary>

```bash
kubectl create job hello-job --image=busybox --dry-run -o yaml -- echo "Hello I am from job" > hello-job.yaml
```

edit the yaml file to add parallelism: 10
```bash
kubectl create -f hello-job.yaml
```

`hello-job.yaml`
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  creationTimestamp: null
  name: hello-job
spec:
  parallelism: 10
  template:
    metadata:
      creationTimestamp: null
    spec:
      containers:
      - command:
        - echo
        - Hello I am from job
        image: busybox
        name: hello-job
        resources: {}
      restartPolicy: Never
status: {}
```

</details>

---

Watch the job that runs 10 times parallelly and verify 10 pods are created and delete those after it’s completed

<details><summary></summary>

```bash
kubectl get job -w
kubectl get po

kubectl delete job hello-job
```

</details>

---

Create a Cronjob with busybox image that prints date and hello from kubernetes cluster message for every minute

<details><summary></summary>

```bash
kubectl create cronjob date-job --image=busybox --schedule="*/1 * * * *" -- bin/sh -c "date; echo Hello from kubernetes cluster"
```

</details>

---

Output the YAML file of the above cronjob

<details><summary></summary>

```bash
kubectl get cj date-job -o yaml
```

</details>

---

Verify that CronJob creating a separate job and pods for every minute to run and verify the logs of the pod

<details><summary></summary>

```bash
kubectl get job
kubectl get po

kubectl logs date-job-<jobid>-<pod>
```

</details>

---

Delete the CronJob and verify all the associated jobs and pods are also deleted.

<details><summary></summary>

```bash
kubectl delete cj date-job
```

verify pods and jobs
```bash
kubectl get po
kubectl get job
```

</details>
