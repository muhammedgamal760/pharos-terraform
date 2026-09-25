# Intentionally simple / slightly sloppy so Auto-Fix has real HCL to patch.

resource "aws_s3_bucket" "logs" {
  bucket = "${var.project}-demo-logs"
}

resource "aws_security_group" "demo" {
  name        = "${var.project}-demo-sg"
  description = "Demo security group used by Pharos Auto-Fix"

  ingress {
    description = "SSH from anywhere — Auto-Fix should tighten this"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "unused" {
  domain = "vpc"
  tags = {
    Name = "${var.project}-unused-eip"
  }
}
