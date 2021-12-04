#!/bin/sh

LOCATION=$location             # the location of your cluster
RESOURCEGROUP=$resource_group  # the name of the resource group where you want to create your cluster
CLUSTER=$clustername           # the name of your cluster
VNET=$vnetname                 # vnet to put the cluster in
VNET_CIDR=$vnet_cidr
CLUSTER_RESOURCE_GROUP=$cluster_resource_group #this group must NOT exist before cluster creation
MASTER_SUBNET_CIDR=$master_subnet_cidr
WORKER_SUBNET_CIDR=$worker_subnet_cidr

#az group create \
#  --name $CLUSTER_RESOURCE_GROUP \
#  --location $LOCATION

az group create \
  --name $RESOURCEGROUP \
  --location $LOCATION

az network vnet create \
   --resource-group $RESOURCEGROUP \
   --name $VNET \
   --address-prefixes $VNET_CIDR

az network vnet subnet create \
  --resource-group $RESOURCEGROUP \
  --vnet-name $VNET \
  --name master-subnet \
  --address-prefixes $MASTER_SUBNET_CIDR \
  --service-endpoints Microsoft.ContainerRegistry

az network vnet subnet create \
  --resource-group $RESOURCEGROUP \
  --vnet-name $VNET \
  --name worker-subnet \
  --address-prefixes $WORKER_SUBNET_CIDR \
  --service-endpoints Microsoft.ContainerRegistry

az network vnet subnet update \
  --name master-subnet \
  --resource-group $RESOURCEGROUP \
  --vnet-name $VNET \
  --disable-private-link-service-network-policies true

az aro create --resource-group $RESOURCEGROUP \
  --cluster-resource-group $CLUSTER_RESOURCE_GROUP \
  --name $CLUSTER \
  --vnet $VNET \
  --master-subnet master-subnet \
  --worker-subnet worker-subnet \
  --worker-count 3 \
  --ingress-visibility private \
  --apiserver-visibility private
