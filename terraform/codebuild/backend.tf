terraform {
  backend "s3" {
    profile              = "default"
    workspace_key_prefix = "workspaces"
    region               = "us-east-1"
    bucket               = "terraform-on-codepipeline-example-tfstate"
    key                  = "pipeline/terraform.tfstate"
    encrypt              = true
  }
}
