output "instance_id" {
  description = "ID da EC2"
  value       = aws_instance.bia_dev.id
}

output "instance_type" {
  description = "Tipo da EC2"
  value       = aws_instance.bia_dev.instance_type
}

output "instance_security_groups" {
  description = "SG da EC2"
  value       = aws_instance.bia_dev.security_groups
}

output "instance_ami" {
  description = "AMI da EC2"
  value       = aws_instance.bia_dev.ami
}

output "instance_public_ip" {
  description = "IP publico da EC2"
  value       = aws_instance.bia_dev.public_ip
}

output "rds_endpoint" {
  description = "Endpoint do RDS da BIA"
  value       = aws_db_instance.bia.endpoint
}

output "rds_secrets_arn" {
  description = "Secrets arn associado ao RDS"
  value       = tolist(aws_db_instance.bia.master_user_secret)[0].secret_arn
}

output "rds_secrets_name" {
  description = "Secrets name associado ao RDS"
  value       = data.aws_secretsmanager_secret.bia_db.name
}

output "rds_secrets_status" {
  description = "Secrets status associado ao RDS"
  value       = tolist(aws_db_instance.bia.master_user_secret)[0].secret_status
}

output "ecr_repo_url" {
  description = "Repositoria da BIA"
  value       = aws_ecr_repository.bia.repository_url
}

output "alb_url" {
  description = "URL do ALB da BIA"
  value       = aws_lb.bia.dns_name
}
