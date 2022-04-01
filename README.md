This helps us learn about:

1) heap memory allocation in node.js/V8
2) requests and limits in kubernetes

Run on k8s
1) set environment variables in `application.properties` if required
2) run
```
k apply -k ./k8s/overlays/development
3) play with different `max_old_space_size` and kubernetes `requests` and `limits` (can be changed in deployment.yaml)
```
4) cleanup
```
k delete -k ./k8s/overlays/development
```