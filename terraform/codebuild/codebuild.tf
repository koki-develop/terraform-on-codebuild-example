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
      pattern                 = "PUSH"
      type                    = "EVENT"
    }
  }
}
