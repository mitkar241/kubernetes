# Readiness Probes
---
A pod has
- Pod Status
- Pod Conditions

# Pod Status
---
Pod Status tells us where the Pod is in its life cycle.

To find the pod status, run
```
kubectl get pods
```
command.

## Pending State
---
When pod is created, it is in `Pending` State.

This is when the scheduler tries to figure out where to place the pod.

If the scheduler can't find a node where to place the pod, the pod will remain in pending state.

To find the reason, run
```
kubectl describe pod
```
command.

## ContainerCreating State
---
Once the pod is scheduled, it goes into `ContainerCreating` state.

The images required for the apps / containers are pulled and the containers start.

## Running State
---
Once ALL the containers in the pod successfully starts, it goes into a `Running` state.

The pod continues to be in this state, until the program either
- runs successfully
- is terminated

# Pod Conditions
---
Pod status is a summary of the current state.

There are times when we may want additional information.

Pod conditions complement pod status.

It is an array of True / False values that tell us state of the pod.

- PodScheduled
- Initialized
- ContainersReady
- Ready

To find the pod conditions, run
```
kubectl describe pod
```
command and check `Conditions` section.

# Waiting Period
---
`Ready` condition indicates that ALL containers inside a pod are currently running and are ready to accept user traffic.

Inside a container we could be running variety of apps. It could be

- a large webserver serving frontend users
- a database service
- a script that performs a job / task

These apps may take some time to get ready - e.g. Jenkins server.

During this wait period, the state of the pod indicates that the pod is `Ready`, which is not very true.

To get details of all components, run
```
kubectl get all
```
command.

# Actual Readiness
---
## Scenario
---
- A `pod` is `created`
- The pod `exposed` to external users using a `service`
- If the app within the container took longer to get ready, the service is unaware of it
- The service sends traffic through, as the container is already in a `Ready state`
- This causes users to hit a container that isn't yet running a live app.
- The user does `not` get `expected response` back

## Reason
---
- By default kubernetes assumes that as soon as container is created, it is ready to serve user traffic.
- So it sets the value of the `Ready condition` to `True`.
- The service relies of the pod's `Ready condition` to route traffic.
- Thus as soon as the service sees the Ready condition, it starts to send traffic to the pod.

## Solution Approach
---
We need a way to tie the `Ready condition` to the actual state of the app inside the container.
