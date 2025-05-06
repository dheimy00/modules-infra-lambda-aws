provider "aws" {
  region = "us-east-1"
}

# Example VPC and subnet configuration
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

resource "aws_security_group" "lambda" {
  name        = "lambda-sg"
  description = "Security group for Lambda function"
  vpc_id      = aws_vpc.example.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lambda-sg"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "lambda" {
  source = "../"

  function_name = "example-lambda-function"
  filename      = "lambda_function.zip"
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  environment_variables = {
    ENVIRONMENT = "production"
    API_KEY     = "your-api-key"
  }

  timeout     = 30
  memory_size = 256

  vpc_config = {
    subnet_ids         = aws_subnet.private[*].id
    security_group_ids = [aws_security_group.lambda.id]
  }

  tags = {
    Environment = "production"
    Project     = "example"
  }
} 