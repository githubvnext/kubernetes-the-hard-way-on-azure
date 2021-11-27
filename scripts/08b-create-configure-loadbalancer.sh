echo "this script needs to be run from Client machine and not in the Controller itself"
## The Kubernetes Frontend Load Balancer

echo "In this section you will provision an external load balancer to front the Kubernetes API Servers. The kubernetes-the-hard-way static IP address will be attached to the resulting load balancer."

echo "> The compute instances created in this tutorial will not have permission to complete this section. **Run the following commands from the same machine used to create the compute instances**."


### Provision a Network Load Balancer

echo "Create the external load balancer network resources:"


{
  KUBERNETES_PUBLIC_IP_ADDRESS=$(az network public-ip show -g kubernetes \
  -n ${CONTROLLER}-pip --query "ipAddress" -otsv)

  echo "Create the load balancer health probe as a pre-requesite for the lb rule that follows."
  az network lb probe create -g kubernetes \
  --lb-name kubernetes-lb \
  --name kubernetes-apiserver-probe \
  --port 6443 \
  --protocol tcp

  echo "Create Loadbalancer Rule"
  az network lb rule create -g kubernetes \
  -n kubernetes-apiserver-rule \
  --protocol tcp \
  --lb-name kubernetes-lb \
  --frontend-ip-name LoadBalancerFrontEnd \
  --frontend-port 6443 \
  --backend-pool-name kubernetes-lb-pool \
  --backend-port 6443 \
  --probe-name kubernetes-apiserver-probe

}


### Verification

echo "> The compute instances created in this tutorial will not have permission to complete this section. **Run the following commands from the same machine used to create the compute instances**."

echo "Retrieve the kubernetes-the-hard-way static IP address:"

KUBERNETES_PUBLIC_IP_ADDRESS=$(az network public-ip show -g kubernetes \
  -n kubernetes-pip --query ipAddress -otsv)


echo "Make a HTTP request for the Kubernetes version info:"


curl --cacert ca.pem https://${KUBERNETES_PUBLIC_IP_ADDRESS}:6443/version
