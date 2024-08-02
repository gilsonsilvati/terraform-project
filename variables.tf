variable "instance_name" {
  type        = string
  description = "Nome da instancia ec2 de trabalho"
  default     = "bia-dev-tf"
}

variable "instance_type" {
  type        = string
  description = "Tipo da instancia ec2 de trabalho"
  default     = "t3.micro"
}

variable "availability_zone" {
  type        = string
  description = "Zona de disponibilidade"
  default     = "us-east-1"
}
