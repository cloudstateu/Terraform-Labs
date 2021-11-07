resource "azurerm_policy_definition" "mf-chm-allowedlocations" {
  name         = "mf-chm-allowedlocations"
  display_name = "mf-chm-allowedlocations"
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Polityka wymuszająca tworzenie zasobów w określonym regionie."

  #management_group_name = data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id

  metadata = <<METADATA
  {
    "version":  "1.0.0",
    "category": "General"
  }
  METADATA


  policy_rule = <<POLICY_RULE
    {
        "if": {
            "allOf": [
            {
                "field": "location",
                "notIn": "[parameters('listOfAllowedLocations')]"
            },
            {
                "field": "location",
                "notEquals": "global"
            },
            {
                "field": "type",
                "notEquals": "Microsoft.AzureActiveDirectory/b2cDirectories"
            }
            ]
        },
        "then": {
            "effect": "deny"
        }
    }
POLICY_RULE


  parameters = <<PARAMETERS
    {
        "listOfAllowedLocations": {
            "type": "Array",
            "metadata": {
                "description": "The list of locations that can be specified when deploying resources.",
                "strongType": "location",
                "displayName": "Allowed locations"
            }
        }
    }
PARAMETERS

}


# resource "azurerm_policy_definition" "CHM-RequireTag-RG" {
#   name = "CHM-RequireTag-RG"
#   display_name = "CHM-RequireTag-RG"
#   policy_type = "Custom"
#   mode = "All"
#   description = "Polityka wymusza, aby zasób posiadał określony tag do sprawdzenia czy wartość jest niepusta"

#   management_group_name = data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id

#   metadata = <<METADATA
#     {
#         "version":  "1.0.0",
#         "category": "Tags"
#     }

# METADATA


#   policy_rule = <<POLICY_RULE
#     {
#       "if": {
#         "allOf": [
#           {
#             "field": "type",
#             "equals": "Microsoft.Resources/subscriptions/resourceGroups"
#           },
#           {
#             "field": "[concat('tags[', parameters('tagName'), ']')]",
#             "exists": "false"
#           },
#           {
#             "field": "name",
#             "notLike": "MC_*"
#           }
#         ]
#       },
#       "then": {
#         "effect": "deny"
#       }
#     }
# POLICY_RULE


#   parameters = <<PARAMETERS
#     {
#       "tagName": {
#         "type": "String",
#         "metadata": {
#           "displayName": "Tag Name",
#           "description": "Name of the tag, such as 'ENV'"
#         }
#       }
#     }
# PARAMETERS

# }

# resource "azurerm_policy_definition" "CHM-AddTag-XXXX" {
#   name = "CHM-AddTag-platforma"
#   display_name = "CHM-AddTag-XXXX"
#   policy_type = "Custom"
#   mode = "All"
#   metadata = <<METADATA
#     {
#         "version":  "1.0.0",
#         "category": "Tags"
#     }
#   METADATA
#   policy_rule = <<POLICY_RULE
#     {
#         "if": {
#           "allOf": [
#             {
#               "field": "type",
#               "equals": "Microsoft.Resources/subscriptions/resourceGroups"
#             },
#             {
#               "field": "[concat('tags[', parameters('tagName'), ']')]",
#               "exists": "false"
#             }
#           ]
#         },
#         "then": {
#           "effect": "append",
#           "details": [
#             {
#               "field": "[concat('tags[', parameters('tagName'), ']')]",
#               "value": "[parameters('tagValue')]"
#             }
#           ]
#         }
#     }
#  POLICY_RULE
#  parameters = <<PARAMETERS
#     {
#         "tagName": {
#           "type": "String",
#           "metadata": {
#             "displayName": "Tag Name",
#             "description": "Name of the tag, such as 'XXXX'"
#           }
#         },
#         "tagValue": {
#           "type": "String",
#           "metadata": {
#             "displayName": "Tag Value",
#             "description": "Value of the tag, such as 'true'"
#           }
#         }
#     }
# PARAMETERS
# }

# resource "azurerm_policy_definition" "CHM-AllowedResources" {
#   name = "CHM-AllowedResources"
#   display_name = "CHM-AllowedResources"
#   policy_type = "Custom"

#   mode = "Indexed"
#   description = "Polityka ograniczająca jakie zasoby mogą być tworzone w Azure"

#   management_group_name = data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id

#   metadata = <<METADATA
#      {
#          "version":  "1.0.0",
#          "category": "General"
#      }
#       METADATA

#   policy_rule = <<POLICY_RULE
#      {
#          "if": {
#            "not": {
#              "field": "type",
#              "in": "[parameters('listOfResourceTypesAllowed')]"
#            }
#          },
#          "then": {
#            "effect": "deny"

#          }
#      }
#      POLICY_RULE

#   parameters = <<PARAMETERS
#      {
#          "listOfResourceTypesAllowed": {
#            "type": "Array",
#            "metadata": {
#              "description": "The list of resource types that can be deployed.",
#              "displayName": "Allowed resource types",
#              "strongType": "resourceTypes"
#            }
#          }
#     }
#     PARAMETERS
# }

# resource "azurerm_policy_definition" "CHM-NetworkWatcherEnabled" {
#   name = "CHM-NetworkWatcherEnabled"
#   display_name = "CHM-NetworkWatcherEnabled"
#   policy_type = "Custom"
#   mode = "Indexed"
#   description = "Network Watcher should be enabled"

#   management_group_name = data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id

#   metadata = <<METADATA
#     {
#         "version":  "1.0.0",
#         "category": "General"
#     }

# METADATA


#   policy_rule = <<POLICY_RULE
#     {
#         "if": {
#           "field": "type",
#           "equals": "Microsoft.Resources/subscriptions"
#         },
#         "then": {
#           "effect": "auditIfNotExists",
#           "details": {
#             "type": "Microsoft.Network/networkWatchers",
#             "resourceGroupName": "[parameters('resourceGroupName')]",
#             "existenceCondition": {
#               "field": "location",
#               "in": "[parameters('listOfLocations')]"
#             }
#           }
#         }
#     }

# POLICY_RULE


#   parameters = <<PARAMETERS
#     {
#         "listOfLocations": {
#           "type": "Array",
#           "metadata": {
#             "displayName": "Locations",
#             "description": "Audit if Network Watcher is not enabled for region(s).",
#             "strongType": "location"
#           }
#         },
#         "resourceGroupName": {
#           "type": "String",
#           "metadata": {
#             "displayName": "NetworkWatcher resource group name",
#             "description": "Name of the resource group of NetworkWatcher, such as NetworkWatcherRG. This is the resource group where the Network Watchers are located."
#           },
#           "defaultValue": "NetworkWatcherRG"
#         }
#     }
# PARAMETERS
# }