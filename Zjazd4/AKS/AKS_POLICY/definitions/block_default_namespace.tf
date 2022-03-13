# -------- Azure Policy - Kubernetes clusters should not use the default namespace ----------

resource "azurerm_policy_definition" "azpoldef-BlockDefaultNamespace" {
  name                  = "azpoldef-BlockDefaultNamespace"
  display_name          = "azpoldef-BlockDefaultNamespace"
  policy_type           = "Custom"
  mode                  = "Microsoft.Kubernetes.Data"
  description           = "Prevent usage of the default namespace in Kubernetes clusters to protect against unauthorized access for ConfigMap, Pod, Secret, Service, and ServiceAccount resource types. For more information, see https://aka.ms/kubepolicydoc."
  management_group_name = data.azurerm_management_group.mg-root.name

  metadata = <<METADATA
    {
      "version": "2.1.2",
      "category": "Kubernetes"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "field": "type",
        "in": [
          "AKS Engine",
          "Microsoft.Kubernetes/connectedClusters",
          "Microsoft.ContainerService/managedClusters"
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "constraintTemplate": "https://store.policy.core.windows.net/kubernetes/block-default-namespace/v1/template.yaml",
          "constraint": "https://store.policy.core.windows.net/kubernetes/block-default-namespace/v1/constraint.yaml",
          "excludedNamespaces": "[parameters('excludedNamespaces')]",
          "namespaces": "[parameters('namespaces')]",
          "labelSelector": "[parameters('labelSelector')]"
        }
      }
    }
  POLICY_RULE

  parameters = <<PARAMETERS
    {
      "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "'audit' allows a non-compliant resource to be created or updated, but flags it as non-compliant. 'deny' blocks the non-compliant resource creation or update. 'disabled' turns off the policy."
        },
        "allowedValues": [
          "audit",
          "deny",
          "disabled"
        ],
        "defaultValue": "audit"
      },
      "excludedNamespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace exclusions",
          "description": "List of Kubernetes namespaces to exclude from policy evaluation. System namespaces \"kube-system\", \"gatekeeper-system\" and \"azure-arc\" are always excluded by design."
        },
        "defaultValue": [
          "kube-system",
          "gatekeeper-system",
          "azure-arc"
        ]
      },
      "namespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace inclusions",
          "description": "List of Kubernetes namespaces to only include in policy evaluation. An empty list means the policy is applied to all resources in all namespaces."
        },
        "defaultValue": [
          "default"
        ]
      },
      "labelSelector": {
        "type": "object",
        "metadata": {
          "displayName": "Kubernetes label selector",
          "description": "Label query to select Kubernetes resources for policy evaluation. An empty label selector matches all Kubernetes resources."
        },
        "defaultValue": {},
        "schema": {
          "description": "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all resources.",
          "type": "object",
          "properties": {
            "matchLabels": {
              "description": "matchLabels is a map of {key,value} pairs.",
              "type": "object",
              "additionalProperties": {
                "type": "string"
              },
              "minProperties": 1
            },
            "matchExpressions": {
              "description": "matchExpressions is a list of values, a key, and an operator.",
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "key": {
                    "description": "key is the label key that the selector applies to.",
                    "type": "string"
                  },
                  "operator": {
                    "description": "operator represents a key's relationship to a set of values.",
                    "type": "string",
                    "enum": [
                      "In",
                      "NotIn",
                      "Exists",
                      "DoesNotExist"
                    ]
                  },
                  "values": {
                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty.",
                    "type": "array",
                    "items": {
                      "type": "string"
                    }
                  }
                },
                "required": [
                  "key",
                  "operator"
                ],
                "additionalProperties": false
              },
              "minItems": 1
            }
          },
          "additionalProperties": false
        }
      }
    }
  PARAMETERS
}
