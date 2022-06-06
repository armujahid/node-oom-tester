This helps us learn about:

1) heap memory allocation in node.js/V8 with and without setting `max_old_space_size`
2) requests and limits in kubernetes
3) if a POD takes more memory than allowed k8s memory limits, kubernetes will kill it using SIGKILL (pod will be terminated
with reason: OOMKilled - exit code: 1)
1) if a POD takes less less memory than allowed k8s memory limits but is killed by V8 (signal SIGABRT) because of `max_old_space_size` we will get something like this in logs. signal SIGABRT has value 6, so the expected exit code will be 128 + 6, or 134. (reference: https://nodejs.org/api/process.html) (pod will be terminated
with reason: Error - exit code: 1)
```
Heap allocated 2 GB
Heap allocated 2.01 GB

<--- Last few GCs --->

[18:0x7f3081c13340]    14003 ms: Mark-sweep (reduce) 2044.5 (2047.8) -> 2044.2 (2047.8) MB, 1011.4 / 0.0 ms  (+ 187.3 ms in 233 steps since start of marking, biggest step 74.0 ms, walltime since start of marking 1363 ms) (average mu = 0.559, current mu = [18:0x7f3081c13340]    15303 ms: Mark-sweep (reduce) 2054.2 (2057.5) -> 2054.0 (2057.5) MB, 1289.4 / 0.0 ms  (average mu = 0.393, current mu = 0.008) allocation failure scavenge might not succeed


<--- JS stacktrace --->

FATAL ERROR: Reached heap limit Allocation failed - JavaScript heap out of memory
npm notice 
npm notice New minor version of npm available! 8.1.2 -> 8.6.0
npm notice Changelog: <https://github.com/npm/cli/releases/tag/v8.6.0>
npm notice Run `npm install -g npm@8.6.0` to update!
npm notice 
npm ERR! path /home/node
npm ERR! command failed
npm ERR! signal SIGABRT
npm ERR! command sh -c node .

npm ERR! A complete log of this run can be found in:
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