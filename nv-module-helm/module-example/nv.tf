module "nv-deployment" {
    source                  = "git::https://github.com/neuvector/terraform//nv-module-helm?ref=feature/cases"
    # neuvector settings
    tag="4.3.1"
    scanner_replicas = "3"
    controller_replicas = "3"
    webui_service = "LoadBalancer"

    # registry settings
    registry_username   = "user"
    #password path file
    registry_password   = "/path/registry.secret"
}