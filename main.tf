
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"    
    }
  }
}

provider "google" {
    project  = "rising-sector-429705-q9"
    region = "us-east1"
    zone = "us-east1-b"
}

provider "azurerm" {
  features {}
}
