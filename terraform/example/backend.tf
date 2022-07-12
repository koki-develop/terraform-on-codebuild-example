terraform {
  backend "s3" {
    profile              = "default"
    workspace_key_prefix = "workspaces"
    region               = "us-east-1"
    bucket               = "tf-on-codebuild-example-tfstate"
    key                  = "example/terraform.tfstate"
    encrypt              = true
  }
}
