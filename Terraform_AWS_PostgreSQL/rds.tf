# RDS Security Group (Referencing separately defined SG)
resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "postgres-subnet-group"
  description = "Subnet group for PostgreSQL RDS"
  subnet_ids  = ["subnet-07e775f8893398c0f", "subnet-0fb154ef283fe544b", "subnet-0332476f368aed74c"]  # Replace with actual subnet IDs
}

resource "aws_db_instance" "postgres" {
  identifier             = "postgres-db-instance"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "17.2"
  instance_class         = "db.t3.micro"
  db_name                = "mydbclass"
  username               = "postgres"
  password               = "password123"  # Use variable or secrets manager in production
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  backup_retention_period = 7
}
