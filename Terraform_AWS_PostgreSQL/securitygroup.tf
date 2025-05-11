resource "aws_security_group" "rds_sg" {
  name        = "rds-postgres-sg"
  description = "Allow PostgreSQL inbound traffic"
  vpc_id      = "vpc-00b92361c22826752"  # Replace with your actual VPC ID

  ingress {
    description = "PostgreSQL from anywhere (0.0.0.0/0) - restrict in production"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with trusted IP range in real use
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-postgres-sg"
  }
}
