#
# TODO; zmiana resource providera
#
resource "azurerm_role_definition" "pkobp-dataexplorer-creator" {
  name        = "pkobp-dataexplorer-creator"
  #TODO - ZMIENIĆ PROVIDER
  provider    = azurerm.provider-dev-dev
  #TODO - zmienić na RESOURCE GROUP
  scope       = "/providers/Microsoft.Management/managementGroups/${data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id}"
  description = "pkobp-dataexplorer-creator"

  permissions {
    actions   = [
#>", #Microsoft.Kusto/register/action", #Subscription Registration Action",
#>", #Microsoft.Kusto/Register/action", #Registers the subscription to the Kusto Resource Provider.",
#>", #Microsoft.Kusto/Unregister/action", #Unregisters the subscription to the Kusto Resource Provider.",
   "Microsoft.Kusto/Clusters/read",
   "Microsoft.Kusto/Clusters/write",
   "Microsoft.Kusto/Clusters/delete",
   "Microsoft.Kusto/Clusters/Start/action"
   "Microsoft.Kusto/Clusters/Stop/action",
"Microsoft.Kusto/Clusters/Activate/action",
"Microsoft.Kusto/Clusters/Deactivate/action", #
"Microsoft.Kusto/Clusters/CheckNameAvailability/action", #
"Microsoft.Kusto/Clusters/DetachFollowerDatabases/action", ##Detaches follower's databases.
"Microsoft.Kusto/Clusters/ListFollowerDatabases/action", ##Lists the follower's databases.",
"Microsoft.Kusto/Clusters/DiagnoseVirtualNetwork/action", ##Diagnoses network connectivity status for external resources on which the service is dependent on.",
"Microsoft.Kusto/Clusters/ListLanguageExtensions/action", ##Lists language extensions.",
"Microsoft.Kusto/Clusters/AddLanguageExtensions/action", ##Add language extensions.",
"Microsoft.Kusto/Clusters/RemoveLanguageExtensions/action", ##Remove language extensions.",
"Microsoft.Kusto/Clusters/AttachedDatabaseConfigurations/read", ##Reads an attached database configuration resource.",
"Microsoft.Kusto/Clusters/AttachedDatabaseConfigurations/write", ##Writes an attached database configuration resource.",
"Microsoft.Kusto/Clusters/AttachedDatabaseConfigurations/delete", ##Deletes an attached database configuration resource.",
"Microsoft.Kusto/Clusters/AttachedDatabaseConfigurations/write", ##Write a script resource.",
"Microsoft.Kusto/Clusters/AttachedDatabaseConfigurations/delete", ##Delete a script resource.",
"Microsoft.Kusto/Clusters/Databases/read", ##Reads a database resource.",
"Microsoft.Kusto/Clusters/Databases/write", ##Writes a database resource.",
"Microsoft.Kusto/Clusters/Databases/delete", ##Deletes a database resource.",
"Microsoft.Kusto/Clusters/Databases/ListPrincipals/action", ##Lists database principals.",
"Microsoft.Kusto/Clusters/Databases/AddPrincipals/action", ##Adds database principals.",
#"Microsoft.Kusto/Clusters/Databases/RemovePrincipals/action", ##Removes database principals.",
"Microsoft.Kusto/Clusters/Databases/DataConnectionValidation/action", ##Validates database data connection.",
"Microsoft.Kusto/Clusters/Databases/CheckNameAvailability/action", ##Checks name availability for a given type.",
"Microsoft.Kusto/Clusters/Databases/EventHubConnectionValidation/action", ##Validates database Event Hub connection.",
"Microsoft.Kusto/Clusters/Databases/DataConnections/read", ##Reads a data connections resource.",
"Microsoft.Kusto/Clusters/Databases/DataConnections/write", ##Writes a data connections resource.",
"Microsoft.Kusto/Clusters/Databases/DataConnections/delete", #Deletes a data connections resource.",
"Microsoft.Kusto/Clusters/Databases/EventHubConnections/read", #Reads an Event Hub connections resource.",
"Microsoft.Kusto/Clusters/Databases/EventHubConnections/write", #Writes an Event Hub connections resource.",
"Microsoft.Kusto/Clusters/Databases/EventHubConnections/delete", #Deletes an Event Hub connections resource.",
"Microsoft.Kusto/Clusters/Databases/PrincipalAssignments/read", #Reads a database principal assignments resource.",
"Microsoft.Kusto/Clusters/Databases/PrincipalAssignments/write", #Writes a database principal assignments resource.",
#"Microsoft.Kusto/Clusters/Databases/PrincipalAssignments/delete", #Deletes a database principal assignments resource.",
"Microsoft.Kusto/Clusters/Databases/Scripts/read", #Reads a script resource.",
"Microsoft.Kusto/Clusters/DataConnections/read", #Reads a cluster's data connections resource.",
"Microsoft.Kusto/Clusters/DataConnections/write", #Writes a cluster's data connections resource.",
#"Microsoft.Kusto/Clusters/DataConnections/delete", #Deletes a cluster's data connections resource.",
#"Microsoft.Kusto/Clusters/ManagedPrivateEndpoints/read", #Reads an attached database configuration resource.",
#"Microsoft.Kusto/Clusters/ManagedPrivateEndpoints/write", #",
#"Microsoft.Kusto/Clusters/ManagedPrivateEndpoints/delete", #",
"Microsoft.Kusto/Clusters/OutboundNetworkDependenciesEndpoints/read", #Reads outbound network dependencies endpoints for a resource",
"Microsoft.Kusto/Clusters/PrincipalAssignments/read", #Reads a Cluster principal assignments resource.",
"Microsoft.Kusto/Clusters/PrincipalAssignments/write", #Writes a Cluster principal assignments resource.",
#"Microsoft.Kusto/Clusters/PrincipalAssignments/delete", #Deletes a Cluster principal assignments resource.",
"Microsoft.Kusto/Clusters/PrivateEndpointConnectionProxies/read", #Reads a private endpoint connection proxy",
"Microsoft.Kusto/Clusters/PrivateEndpointConnectionProxies/write", #Writes a private endpoint connection proxy",
#"Microsoft.Kusto/Clusters/PrivateEndpointConnectionProxies/delete", #Deletes a private endpoint connection proxy",
"Microsoft.Kusto/Clusters/PrivateEndpointConnections/read", #Reads a private endpoint connection",
"Microsoft.Kusto/Clusters/PrivateEndpointConnections/write", #Writes a private endpoint connection",
#"Microsoft.Kusto/Clusters/PrivateEndpointConnections/delete", #Deletes a private endpoint connection",
"Microsoft.Kusto/Clusters/PrivateLinkResources/read", #Reads private link resources",
"Microsoft.Kusto/Clusters/providers/Microsoft.Insights/diagnosticSettings/read", #Gets the diagnostic settings for the resource",
#"Microsoft.Kusto/Clusters/providers/Microsoft.Insights/diagnosticSettings/write", #Creates or updates the diagnostic setting for the resource",
"Microsoft.Kusto/Clusters/providers/Microsoft.Insights/logDefinitions/read", #Gets the diagnostic logs settings for the resource",
"Microsoft.Kusto/Clusters/providers/Microsoft.Insights/metricDefinitions/read", #Gets the metric definitions of the resource",
"Microsoft.Kusto/Clusters/SKUs/read", #Reads a cluster SKU resource.",
"Microsoft.Kusto/Clusters/SKUs/PrivateEndpointConnectionProxyValidation/action", #Validates a private endpoint connection proxy",
"Microsoft.Kusto/Locations/CheckNameAvailability/action", #Checks resource name availability.",
"Microsoft.Kusto/locations/operationresults/read", #Reads operations resources",
"Microsoft.Kusto/Operations/read", #Reads operations resources",
"Microsoft.Kusto/SKUs/read", #Reads a SKU resource.",
    ]
    not_actions = []
  }
}