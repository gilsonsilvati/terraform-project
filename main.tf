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
    name = "bia-dev"
    description = "acesso da maquina de trabalho"
    vpc_id = "vpc-0468e2c0c68b1b069"

    ingress {
        description = "liberado para o mundo"
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
    vpc_security_group_ids = [ aws_security_group.bia_dev.id ]
    root_block_device {
      volume_size = 12
    }
    iam_instance_profile = aws_iam_instance_profile.role_acesso_ssm.name
    user_data = file("user-data/user_data_ec2.sh")
}
