This helps us learn about:

1) heap memory allocation in node.js/V8 with and without setting `max_old_space_size`
2) requests and limits in kubernetes
3) if a POD takes more memory than allowed k8s memory limits, kubernetes will kill it using SIGKILL (pod will be terminated
with reason: OOMKilled - exit code: 137)
1) if a POD takes less less memory than allowed k8s memory limits but is killed by V8 (signal SIGSEGV signal 11) because of `max_old_space_size` we will get something like this in logs. (pod will be terminated
with reason: Error - exit code: 139)
```
Heap allocated 0.99 GB
Heap allocated 1 GB
Heap allocated 1 GB

<--- Last few GCs --->

[1:0x7fe7c9936340]     5298 ms: Scavenge (reduce) 1019.0 (1021.6) -> 1019.0 (1021.6) MB, 1.3 / 0.0 ms  (average mu = 0.715, current mu = 0.571) allocation failure 
[1:0x7fe7c9936340]     5607 ms: Mark-sweep (reduce) 1028.7 (1031.3) -> 1028.6 (1031.3) MB, 210.0 / 0.0 ms  (+ 247.5 ms in 521 steps since start of marking, biggest step 77.7 ms, walltime since start of marking 483 ms) (average mu = 0.570, current mu = 0.2

<--- JS stacktrace --->

FATAL ERROR: Reached heap limit Allocation failed - JavaScript heap out of memory
```

Docker image: https://hub.docker.com/repository/docker/armujahid/node-oom-tester

Deployment on k8s:
1) run
```
1) k apply -k ./k8s/overlays/development
2) play with different `max_old_space_size` (can be changed in `application.properties`) and kubernetes memory `limits` (can be changed in deployment.yaml)
```
3) cleanup
```
k delete -k ./k8s/overlays/development
```