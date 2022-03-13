# Log in first with az login if you're not using Cloud Shell

az provider register --namespace Microsoft.PolicyInsights

aksName=aks01
aksRG=aksrg

az aks enable-addons --addons azure-policy --name $aksName --resource-group $aksRG

az aks get-credentials -n $aksName -g $aksRG

# azure-policy pod is installed in kube-system namespace
kubectl get pods -n kube-system
# gatekeeper pod is installed in gatekeeper-system namespace
kubectl get pods -n gatekeeper-system

kubectl get constrainttemplates

az aks show --query addonProfiles.azurepolicy -n $aksName -g $aksRG

ASSIGN POLICY: Kubernetes cluster pod security baseline standards for Linux-based workloads

kubectl apply -f nginx-privileged.yaml



https://docs.microsoft.com/en-us/azure/aks/use-azure-policy
