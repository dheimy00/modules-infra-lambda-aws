# AWS Lambda Terraform Module

This Terraform module creates an AWS Lambda function with all necessary resources including IAM role, CloudWatch log group, and basic execution role. It also supports VPC configuration for running Lambda functions within a VPC.

## Features

- Creates Lambda function with configurable settings
- Sets up IAM role with basic Lambda execution permissions
- Configures CloudWatch log group with configurable retention period
- Supports environment variables
- Configurable memory and timeout settings
- Tagging support
- VPC configuration support with subnet and security group settings

## Usage

```hcl
module "lambda" {
  source = "path/to/module"

  function_name = "my-lambda-function"
  filename      = "lambda_function.zip"
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  environment_variables = {
    ENVIRONMENT = "production"
    API_KEY     = "your-api-key"
  }

  timeout     = 30
  memory_size = 256

  # VPC Configuration
  vpc_config = {
    subnet_ids         = ["subnet-12345678", "subnet-87654321"]
    security_group_ids = ["sg-12345678"]
  }

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| function_name | Name of the Lambda function | `string` | n/a | yes |
| filename | Path to the function's deployment package | `string` | n/a | yes |
| handler | Function entrypoint in your code | `string` | `"index.handler"` | no |
| runtime | Runtime environment for the Lambda function | `string` | `"nodejs18.x"` | no |
| timeout | Amount of time your Lambda function has to run in seconds | `number` | `30` | no |
| memory_size | Amount of memory in MB your Lambda function can use at runtime | `number` | `128` | no |
| publish | Whether to publish creation/change as new Lambda Function Version | `bool` | `false` | no |
| environment_variables | Environment variables for the Lambda function | `map(string)` | `{}` | no |
| log_retention_in_days | Specifies the number of days you want to retain log events | `number` | `14` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| vpc_config | VPC configuration for the Lambda function | `object` | `null` | no |

### VPC Configuration

The `vpc_config` object accepts the following attributes:

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| subnet_ids | List of subnet IDs for the Lambda function | `list(string)` | yes |
| security_group_ids | List of security group IDs for the Lambda function | `list(string)` | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda_function_arn | The ARN of the Lambda function |
| lambda_function_name | The name of the Lambda function |
| lambda_function_invoke_arn | The ARN to be used for invoking Lambda Function from API Gateway |
| lambda_role_arn | The ARN of the IAM role created for the Lambda function |
| lambda_role_name | The name of the IAM role created for the Lambda function |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.0 |

## License

MIT 