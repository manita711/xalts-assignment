# Define provider and region
provider "aws" {
  region = "ap-south-1"
}

# Create a security group for the EC2 instance
resource "aws_security_group" "api_sg" {
    name        = "api-security-group1"
    description = "Security group for API EC2 instance"

# Allow inbound traffic on port 80 (HTTP) and 5000 (Flask app)
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   } 
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic to all destinations
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "api_instance" {
  ami           = "ami-0f58b397bc5c1f2e8"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "demo"
  user_data = filebase64("${path.module}/cloud_init_config.yaml")
  security_groups = [aws_security_group.api_sg.name]
}

output "public_ip" {
  value = aws_instance.api_instance.public_ip
}