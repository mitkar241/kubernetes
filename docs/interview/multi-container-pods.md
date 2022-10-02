# Multi-Container Pods
---
Practice questions based on these concepts
- Understand multi-container pod design patterns (eg: ambassador, adaptor, sidecar)

---

Create a Pod with three busy box containers with commands “ls; sleep 3600;”, “echo Hello World; sleep 3600;” and “echo this is the third container; sleep 3600” respectively and check the status

<details><summary></summary>

first create single container pod with dry run flag
```bash
kubectl run busybox --image=busybox --restart=Never --dry-run -o yaml -- bin/sh -c "sleep 3600; ls" > multi-container.yaml
```

edit the pod to following yaml and create it
```bash
kubectl create -f multi-container.yaml
kubectl get po busybox
```

`multi-container.yaml`
```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: busybox
  name: busybox
spec:
  containers:
  - args:
    - bin/sh
    - -c
    - ls; sleep 3600
    image: busybox
    name: busybox1
    resources: {}
  - args:
    - bin/sh
    - -c
    - echo Hello world; sleep 3600
    image: busybox
    name: busybox2
    resources: {}
  - args:
    - bin/sh
    - -c
    - echo this is third container; sleep 3600
    image: busybox
    name: busybox3
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}
```

</details>

---

Check the logs of each container that you just created

<details><summary></summary>

```bash
kubectl logs busybox -c busybox1
kubectl logs busybox -c busybox2
kubectl logs busybox -c busybox3
```

</details>

---

Check the previous logs of the second container busybox2 if any

<details><summary></summary>

```bash
kubectl logs busybox -c busybox2 --previous
```

</details>

---

Run command ls in the third container busybox3 of the above pod

<details><summary></summary>

```bash
kubectl exec busybox -c busybox3 -- ls
```

</details>

---

Show metrics of the above pod containers and puts them into the file.log and verify

<details><summary></summary>

```bash
kubectl top pod busybox --containers
```

putting them into file
```bash
kubectl top pod busybox --containers > file.log
cat file.log
```

</details>

---

Create a Pod with main container busybox and which executes this “while true; do echo ‘Hi I am from Main container’ >> /var/log/index.html; sleep 5; done” and with sidecar container with nginx image which exposes on port 80. Use emptyDir Volume and mount this volume on path /var/log for busybox and on path /usr/share/nginx/html for nginx container. Verify both containers are running.

<details><summary></summary>

create an initial yaml file with this
```bash
kubectl run multi-cont-pod --image=busbox --restart=Never --dry-run -o yaml > multi-container.yaml
```

edit the yml as below and create it
```bash
kubectl create -f multi-container.yaml
kubectl get po multi-cont-pod
```

`multi-container.yaml`
```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: multi-cont-pod
  name: multi-cont-pod
spec:
  volumes:
  - name: var-logs
    emptyDir: {}
  containers:
  - image: busybox
    command: ["/bin/sh"]
    args: ["-c", "while true; do echo 'Hi I am from Main container' >> /var/log/index.html; sleep 5;done"]
    name: main-container
    resources: {}
    volumeMounts:
    - name: var-logs
      mountPath: /var/log
  - image: nginx
    name: sidecar-container
    resources: {}
    ports:
      - containerPort: 80
    volumeMounts:
    - name: var-logs
      mountPath: /usr/share/nginx/html
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}
```

</details>

---

Exec into both containers and verify that main.txt exist and query the main.txt from sidecar container with curl localhost

<details><summary></summary>

exec into main container
```bash
kubectl exec -it  multi-cont-pod -c main-container -- sh
cat /var/log/main.txt
```

exec into sidecar container
```bash
kubectl exec -it  multi-cont-pod -c sidecar-container -- sh
cat /usr/share/nginx/html/index.html
```

install curl and get default page
```bash
kubectl exec -it  multi-cont-pod -c sidecar-container -- sh
# apt-get update && apt-get install -y curl
# curl localhost
```

</details>
