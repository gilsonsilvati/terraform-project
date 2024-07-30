resource "aws_instance" "bia_dev" {
    ami = "ami-0b72821e2f351e396"
    instance_type = "t3.micro"
    tags = {
        Name = var.instance_name
        ambiente = "dev"
    }
    subnet_id = local.subnet_zona_a
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.bia_dev.id]
    root_block_device {
      volume_size = 12
    }
    iam_instance_profile = aws_iam_instance_profile.role_acesso_ssm.name
    user_data = file("userdata/userdata_biadev.sh")
}
