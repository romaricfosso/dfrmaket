data "template_file" "user_data" {
  #template = file("./modules/ec2/user_data/wordpress.sh")
  template = templatefile("${path.module}/user_data/wordpress.sh", {
    DB_NAME     = var.db_name
    DB_USER     = var.db_user
    DB_PASSWORD = var.db_password
    DB_HOST     = var.db_host
  })

}


data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
data "aws_db_instance" "wordpress" {
  db_instance_identifier = "${var.db_name}-instance"
}

