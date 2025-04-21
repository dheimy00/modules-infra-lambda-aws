# AWS Lambda Infrastructure with Terraform (Python)

This repository contains Terraform configurations to deploy an AWS Lambda function with all necessary resources.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.0.0)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- Python 3.9 or later
- AWS Lambda function code packaged as a ZIP file

## Python Lambda Function Structure

Your Python Lambda function should follow this structure:
```
lambda_function/
├── lambda_function.py
└── requirements.txt
```

Example `lambda_function.py`:
```python
def lambda_handler(event, context):
    print("Hello from Lambda!")
    return {
        'statusCode': 200,
        'body': 'Hello from Lambda!'
    }
```

To create the deployment package:
```bash
# Create a virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Create deployment package
pip install --target ./package -r requirements.txt
cd package
zip -r ../deployment-package.zip .
cd ..
zip deployment-package.zip lambda_function.py
```

## Configuration

1. Create a `terraform.tfvars` file with your specific configuration:

```hcl
aws_region = "us-east-1"
lambda_function_name = "my-python-lambda"
lambda_handler = "lambda_function.lambda_handler"
lambda_runtime = "python3.9"
lambda_zip_path = "path/to/your/deployment-package.zip"
lambda_environment_variables = {
  ENV_VAR_1 = "value1"
  ENV_VAR_2 = "value2"
}
```

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. To destroy the infrastructure:
```bash
terraform destroy
```

## Infrastructure Components

- AWS Lambda function with Python runtime
- IAM role and policy for Lambda execution
- CloudWatch log group for Lambda logs

## Outputs

After applying the configuration, Terraform will output:
- Lambda function ARN
- Lambda function name
- IAM role ARN
- CloudWatch log group name

## Variables

All configurable variables are defined in `variables.tf` with their descriptions and default values. 