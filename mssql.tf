resource "aws_db_subnet_group" "default_rds_mssql" {
  name        = "mssql-subnet-group"
  description = "rds-mssql private subnet group."
  subnet_ids  = [aws_subnet.private-subnet-2.id, aws_subnet.private-subnet-3.id]

  tags = {
    Name = "private-rds-mssql-subnet-group"

  }
}
resource "aws_db_instance" "database" {
  depends_on             = [aws_subnet.private-subnet-2, aws_subnet.private-subnet-3]
  identifier             = "quickappdb"
  allocated_storage      = 20
  storage_type           = "gp2"
  publicly_accessible    = false
  license_model          = "license-included"
  engine                 = "sqlserver-ex"
  engine_version         = "15.00"
  instance_class         = "db.t3.small"
  multi_az               = false
  username               = "sa"
  password               = var.pass
  availability_zone      = "ap-southeast-1a"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.allows-mssql.id]
  db_subnet_group_name   = aws_db_subnet_group.default_rds_mssql.id

}

output "db_endpoint" {
  value = aws_db_instance.database.address
}
