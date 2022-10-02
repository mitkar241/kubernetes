# Core Concepts
---
Practice questions based on these concepts
- Understand Kubernetes API Primitives
- Create and Configure Basic Pods

---

List all the namespaces in the cluster

<details><summary></summary>

```bash
kubectl get namespaces
kubectl get ns
```

</details>

---

List all the pods in all namespaces

<details><summary></summary>

```bash
kubectl get po --all-namespaces
```

</details>

---

List all the pods in the particular namespace

<details><summary></summary>

```bash
kubectl get po -n <namespace name>
```

</details>

---

List all the services in the particular namespace

<details><summary></summary>

```bash
kubectl get svc -n <namespace name>
```

</details>

---

List all the pods showing name and namespace with a json path expression

<details><summary></summary>

```bash
kubectl get pods -o=jsonpath="{.items[*]['metadata.name', 'metadata.namespace']}"
```

</details>

---

Create an nginx pod in a default namespace and verify the pod running

<details><summary></summary>

Creating a pod
```bash
kubectl run nginx --image=nginx --restart=Never
```

List the pod
```bash
kubectl get po
```

</details>

---

Create the same nginx pod with a yaml file

<details><summary></summary>

```yaml
// get the yaml file with --dry-run flag
kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml > nginx-pod.yaml
// cat nginx-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}
// create a pod 
kubectl create -f nginx-pod.yaml
```

</details>

---

Output the yaml file of the pod you just created

<details><summary></summary>

```bash
kubectl get po nginx -o yaml
```

</details>

---

Output the yaml file of the pod you just created without the cluster-specific information

<details><summary></summary>

```bash
kubectl get po nginx -o yaml --export
```

</details>

---

Get the complete details of the pod you just created

<details><summary></summary>

```bash
kubectl describe pod nginx
```

</details>

---

Delete the pod you just created

<details><summary></summary>

```bash
kubectl delete po nginx
kubectl delete -f nginx-pod.yaml
```

</details>

---

Delete the pod you just created without any delay (force delete)

<details><summary></summary>

```bash
kubectl delete po nginx --grace-period=0 --force
```

</details>

---

Create the nginx pod with version 1.17.4 and expose it on port 80

<details><summary></summary>

```bash
kubectl run nginx --image=nginx:1.17.4 --restart=Never --port=80
```

</details>

---

Change the Image version to 1.15-alpine for the pod you just created and verify the image version is updated

<details><summary></summary>

```bash
kubectl set image pod/nginx nginx=nginx:1.15-alpine
kubectl describe po nginx
```

Another way it will open vi editor and change the version
```bash
kubectl edit po nginx
kubectl describe po nginx
```

</details>

---

Change the Image version back to 1.17.1 for the pod you just updated and observe the changes

<details><summary></summary>

```bash
kubectl set image pod/nginx nginx=nginx:1.17.1
kubectl describe po nginx

# watch it
kubectl get po nginx -w
```

</details>

---

Check the Image version without the describe command

<details><summary></summary>

```bash
kubectl get po nginx -o jsonpath='{.spec.containers[].image}{"\n"}'
```

</details>

---

Create the nginx pod and execute the simple shell on the pod

<details><summary></summary>

creating a pod
```bash
kubectl run nginx --image=nginx --restart=Never
```

exec into the pod
```bash
kubectl exec -it nginx /bin/sh
```

</details>

---

Get the IP Address of the pod you just created

<details><summary></summary>

```bash
kubectl get po nginx -o wide
```

</details>

---

Create a busybox pod and run command ls while creating it and check the logs

<details><summary></summary>

```bash
kubectl run busybox --image=busybox --restart=Never -- ls
kubectl logs busybox
```

</details>

---

If pod crashed check the previous logs of the pod

<details><summary></summary>

```bash
kubectl logs busybox -p
```

</details>

---

Create a busybox pod with command sleep 3600

<details><summary></summary>

```bash
kubectl run busybox --image=busybox --restart=Never -- /bin/sh -c "sleep 3600"
```

</details>

---

Check the connection of the nginx pod from the busybox pod

<details><summary></summary>

```bash
kubectl get po nginx -o wide
```

check the connection
```bash
kubectl exec -it busybox -- wget -o- <IP Address>
```

</details>

---

Create a busybox pod and echo message ‘How are you’ and delete it manually

<details><summary></summary>

```bash
kubectl run busybox --image=nginx --restart=Never -it -- echo "How are you"
kubectl delete po busybox
```

</details>

---

Create a busybox pod and echo message ‘How are you’ and have it deleted immediately

<details><summary></summary>

```bash
# notice the --rm flag
kubectl run busybox --image=nginx --restart=Never -it --rm -- echo "How are you"
```

</details>

---

Create an nginx pod and list the pod with different levels of verbosity

<details><summary></summary>

create a pod
```bash
kubectl run nginx --image=nginx --restart=Never --port=80
```

List the pod with different verbosity
```bash
kubectl get po nginx --v=7
kubectl get po nginx --v=8
kubectl get po nginx --v=9
```

</details>

---

List the nginx pod with custom columns POD_NAME and POD_STATUS

<details><summary></summary>

```bash
kubectl get po -o=custom-columns="POD_NAME:.metadata.name, POD_STATUS:.status.containerStatuses[].state"
```

</details>

---

List all the pods sorted by name

<details><summary></summary>

```bash
kubectl get pods --sort-by=.metadata.name
```

</details>

---

List all the pods sorted by created timestamp

<details><summary></summary>

```bash
kubectl get pods--sort-by=.metadata.creationTimestamp
```

</details>
