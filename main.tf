terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.16"
        }
    }

    required_version = ">= 1.2.0"
}

provider "aws" {
    region = "us-east-1"
    profile = "bia"
}

resource "aws_security_group" "bia_dev" {
    name = "bia-dev-tf"
    description = "Regra para a instancia de trabalho bia-dev com tf"
    vpc_id = "vpc-0468e2c0c68b1b069"

    ingress {
        description = "Liberado 3001 para o mundo"
        from_port = 3001
        to_port = 3001
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "bia-dev" {
    ami = "ami-0b72821e2f351e396"
    instance_type = "t3.micro"
    tags = {
        Name = var.instance_name
        ambiente = "dev"
    }
    # vpc_security_group_ids = [ "sg-09d7b7a4d1599d938" ]
    vpc_security_group_ids = [ aws_security_group.bia_dev.id ]
    root_block_device {
      volume_size = 12
    }
}
