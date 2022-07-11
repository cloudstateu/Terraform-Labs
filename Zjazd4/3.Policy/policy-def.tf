resource "azurerm_policy_definition" "policy-locations" {
  name         = local.policy_name
  display_name = local.policy_name
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Polityka wymuszająca tworzenie zasobów w określonym regionie."

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

resource "azurerm_policy_definition" "policy-tags" {
  name         = local.policy_tags_name
  display_name = local.policy_tags_name
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Polityka wymusza, aby zasób posiadał określony tag do sprawdzenia czy wartość jest niepusta"

  metadata = <<METADATA
     {
         "version":  "1.0.0",
         "category": "Tags"
     }

 METADATA


  policy_rule = <<POLICY_RULE
     {
       "if": {
         "allOf": [
           {
             "field": "type",
             "equals": "Microsoft.Resources/subscriptions/resourceGroups"
           },
           {
             "field": "[concat('tags[', parameters('tagName'), ']')]",
             "exists": "false"
           },
           {
             "field": "name",
             "notLike": "MC_*"
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
       "tagName": {
         "type": "String",
         "metadata": {
           "displayName": "Tag Name",
           "description": "Name of the tag, such as 'ENV'"
         }
       }
     }
 PARAMETERS

}