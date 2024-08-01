resource "aws_autoscaling_group" "ecs" {
  name                      = "cluster-ecs-bia-asg"
  vpc_zone_identifier       = [local.subnet_zona_a, local.subnet_zona_b]
  min_size                  = 0
  max_size                  = 2
  desired_capacity          = 1
  health_check_type         = "EC2"
  health_check_grace_period = 0
  protect_from_scale_in     = false

  launch_template {
    id      = aws_launch_template.ecs_ec2.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "cluster-bia-tf"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "dev"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }
}
