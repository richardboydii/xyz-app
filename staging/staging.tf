# We'll pull state from the xyz-infrastructure terraform state in S3.
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "xyz-demo-tf-state"
    key    = "xyz-vpc-eks-state"
    region = "us-east-2"
  }
}

# Retrieve EKS cluster region.
provider "aws" {
  region = data.terraform_remote_state.eks.outputs.region
}

# Retrieve the EKS cluster name.
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

# Define the kubernetes provider using the aws_eks_cluster defined above.
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}

# This defines the kubernetes deployment for the demo app.
resource "kubernetes_deployment" "xyz-demo-stage" {
  metadata {
    name = "xyz-demo-app-stage"
    labels = {
      App = "XYZDemoAppStage"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "XYZDemoAppStage"
      }
    }
    template {
      metadata {
        labels = {
          App = "XYZDemoAppStage"
        }
      }
      spec {
        container {
          image = var.stage_image
          name  = "xyzdemoappstage"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

# Define a load balancer for our demo app.

resource "kubernetes_service" "xyz-demo-elb-stage" {
  metadata {
    name = "xyz-demo-elb-stage"
  }
  spec {
    selector = {
      App = kubernetes_deployment.xyz-demo-app-stage.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

output "lb_ip" {
  value = kubernetes_service.xyz-demo-elb-stage.status.0.load_balancer.0.ingress.0.hostname
}