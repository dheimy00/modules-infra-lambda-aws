terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "lambda_function" {
  source = "./modules/lambda"

  lambda_function_name    = var.lambda_function_name
  lambda_handler          = var.lambda_handler
  lambda_runtime          = var.lambda_runtime
  lambda_timeout          = var.lambda_timeout
  lambda_memory_size      = var.lambda_memory_size
  lambda_zip_path         = var.lambda_zip_path
  lambda_environment_variables = var.lambda_environment_variables
  log_retention_days      = var.log_retention_days
  tags                    = var.tags
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.log_retention_days
} 