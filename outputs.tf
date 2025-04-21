output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda_function.lambda_function_arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda_function.lambda_function_name
}

output "lambda_role_arn" {
  description = "ARN of the IAM role used by the Lambda function"
  value       = module.lambda_function.lambda_role_arn
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = module.lambda_function.cloudwatch_log_group_name
}

output "lambda_invoke_arn" {
  description = "ARN to be used for invoking the Lambda function from API Gateway"
  value       = module.lambda_function.lambda_invoke_arn
} 