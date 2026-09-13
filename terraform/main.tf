data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-arm64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

variable "admin_cidr" {
  description = "Public IPv4 CIDR allowed to SSH into the EC2 server"
  type        = string
}

resource "aws_security_group" "app_sg" {
  name        = "jenkins-cicd-app-sg"
  description = "Security group for CI/CD demo application"

  # Node.js application
  ingress {
    description = "Node.js application"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH - only your IP
  ingress {
    description = "SSH from admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "app_key" {
  key_name   = "jenkins-cicd-ec2-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t4g.micro"
  key_name      = aws_key_pair.app_key.key_name

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "jenkins-cicd-app-server"
  }
}

resource "aws_s3_bucket" "app_bucket" {
  bucket_prefix = "jenkins-aws-cicd-"
  force_destroy = true

  tags = {
    Name = "jenkins-cicd-storage"
  }
}
