data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "ecs_ec2" {
  name          = "cluster-bia-web"
  image_id      = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type = var.instance_type
  iam_instance_profile { arn = aws_iam_instance_profile.ecs_node.arn }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.bia_ec2.id]
    # ipv6_address_count          = 1
  }

  monitoring { enabled = false }

  user_data = base64encode(<<-EOF
      #!/bin/bash
      echo ECS_CLUSTER=${aws_ecs_cluster.cluster_bia.name} >> /etc/ecs/ecs.config;
    EOF
  )
}
