resource "azurerm_monitor_action_group" "team-ango" {
  name                = "team-ango-action-group"
  resource_group_name = azurerm_resource_group.rg-build-farm.name
  short_name          = "team-ango"

  email_receiver {
    name          = "SendToAngo"
    email_address = var.emailAddress
  }
}

resource "azurerm_monitor_metric_alert" "sa-alert" {
  name                = "sa-metricalert"
  resource_group_name = azurerm_resource_group.rg-build-farm.name
  scopes              = [azurerm_storage_account.sa-build-farm.id]
  description         = "Action will be triggered when Transactions count is greater than 50."

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Transactions"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 50

    dimension {
      name     = "ApiName"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.team-ango.id
  }
}
