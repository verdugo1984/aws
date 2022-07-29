terraform {
 required_version = ">=0.13.1" 
 required_providers {
   aws =">=4.22.0" 
   local = ">=2.2.3"
  }
}

provider "aws" {
    region = "us-east-2"
  }