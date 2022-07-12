resource "aws_codebuild_project" "default" {
  name         = "${local.prefix}-project"
  service_role = aws_iam_role.codebuild.arn

  source {
    buildspec       = "terraform/codebuild/buildspec.yml"
    git_clone_depth = 1
    location        = "https://github.com/koki-develop/terraform-on-codebuild-example.git"
    type            = "GITHUB"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:6.0-22.06.30"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "TF_VERSION"
      value = "1.2.3"
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
}

resource "aws_codebuild_webhook" "default" {
  project_name = aws_codebuild_project.default.name
  build_type   = "BUILD"

  filter_group {
    filter {
      exclude_matched_pattern = false
      # NOTE:こうすれば push 時にビルドできる
      # pattern                 = "PUSH"
      pattern = "PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED, PULL_REQUEST_REOPENED"
      type    = "EVENT"
    }
  }
}
