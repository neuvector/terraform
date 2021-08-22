locals {
  license_file = file(var.license)
  eula_yaml = yamlencode({
    license_key = local.license_file
  })

  user_yaml = yamlencode({
    users = [
      {
        Email = "test1@nv.com", 
        Fullname = "readeruser", 
        Password = var.reader_pass,
        Role  = "reader",
        Timeout = 3600
      },
      {
        Fullname = "admin",
        Password = var.admin_pass,
        Role  = "admin",
        Timeout = 3600
      }
    ]
  })

  registry_password = file(var.registry_password)
  registry_username = var.registry_username
}

#NAMESPACE CONF
resource "kubernetes_namespace" "nv-ns" {
  metadata {
    
    labels = {
      mylabel = "neuvector"
    }

    name = var.ns
  }
}

#SECRET DOCKERHUB CONF
resource "kubernetes_secret" "registry" {
  metadata {
    name = "regsecret"
    namespace = var.ns
  }

  data = {
    ".dockerconfigjson" = <<DOCKER
{
  "auths": {
    "${var.registry_server}": {
      "auth": "${base64encode("${local.registry_username}:${local.registry_password}")}"
    }
  }
}
DOCKER
  }

  type = "kubernetes.io/dockerconfigjson"
  depends_on = [kubernetes_namespace.nv-ns]
}

#HELM RELEASE CONF
resource "helm_release" "nv-helm" {
 name       = var.helm_name
 namespace  =  var.ns
 repository = var.helm_repo
 chart      = var.helm_chart

   set {
     name  = "imagePullSecrets"
     value = var.secret_name
   }
   set {
     name  = "cve.scanner.replicas"
     value = var.scanner_replicas
   }
   set {
     name  = "controller.replicas"
     value = var.controller_replicas
   }
   
   dynamic "set" {
    for_each = var.with_configmap == true ? [var.with_configmap] : []
    content {
      name  = "controller.configmap.enabled"
      value = set.value
    }
  }
   
  dynamic "set" {
    for_each =  var.with_configmap == true ? [var.with_configmap] : []
    content {
      name  = "controller.configmap.data"
      value = yamlencode({"a"="b"})
    }
  }

    set {
      name = "manager.svc.type"
      value = var.webui_service
    }

   set {
     name  = "tag"
     value = var.tag
   }

   set {
     name  = "containerd.enabled"
     value = var.containerd
   }

   set {
     name  = "containerd.path"
     value = var.containerd_path
   }

   depends_on = [kubernetes_secret.registry]
}
