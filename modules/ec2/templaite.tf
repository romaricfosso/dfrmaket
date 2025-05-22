resource "aws_launch_template" "wordpress" {
  name_prefix   = "wordpress-"
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = base64encode(data.template_file.user_data.rendered)

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  vpc_security_group_ids = [var.sg_ec2_id]

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = "wordpress-ec2"
    })
  }

  lifecycle {
    prevent_destroy       = false
    create_before_destroy = true
  }

}
