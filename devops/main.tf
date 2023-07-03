terraform {
  required_version = ">= 0.13.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.0"
    }
    linode = {
      source  = "linode/linode"
      version = ">= 1.95.1"
    }
    ansible = {
      source  = "ansible/ansible"
      version = ">= 1.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0.0"
    }
  }

  # Put .tfstate into Linode s3 cloud storage instead of a local
  # backend "s3" {}
  # Used for S3 cloud object storage
  # terraform -chdir=./devops init --backend-config=backend 
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
}

provider "cloudflare" {
  api_key = var.cloudflare_api_key
  email   = var.cloudflare_email
}

provider "linode" {
  token = var.linode_token
}

provider "tls" {}
