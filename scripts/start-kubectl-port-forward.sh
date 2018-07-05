#!/bin/bash
# Start kubectl on port 2100 -
# since kubectl port-forward only listens on 127.0.0.1, we create a 0.0.0.0 listener with socat afterwards, that forwards to 2100 hardcoded

# Used Environment-Variables
# LOCAL_PORT: Incoming port that is forwarded to the kubectl forwarded port
# KUBE_POD_SPEC: Some selector for determining the target pod (e.g. "deployments/myDeploymentName"
# KUBE_POD_PORT: The Port on the kubernetes pod that should be exposed on LOCAL_PORT
# KUBE_CONFIG: Path to a kubernetes config file that configures access etc.
# KUBE_CONTEXT: Kubernetes Context to be used
# KUBE_NAMESPACE: Kubernetes Namespace to be used


socat TCP4-LISTEN:$LOCAL_PORT,reuseaddr,fork TCP4:localhost:2100 &

kubectl --kubeconfig $KUBE_CONFIG --context $KUBE_CONTEXT --namespace $KUBE_NAMESPACE port-forward $KUBE_POD_SPEC 2100:$KUBE_POD_PORT



# tmp commands
#socat TCP4-LISTEN:42005,reuseaddr,fork TCP4:localhost:2100 &

#kubectl --kubeconfig /kube/config --context k8s.test.odm.bmw-fleet.net --namespace odm-cscs port-forward deployments/phillirdstestforward 2100:80


#docker run -it --rm -p 42005:42005 -e http_proxy -e https_proxy -v ~/.kube:/kube:ro peez/playground