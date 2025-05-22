
data "aws_route53_zone" "dfr_itech" {
  name         = "dfr-itech.com."
  private_zone = false
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
# data "aws_db_instance" "wordpress" {
#   db_instance_identifier = "${var.db_name}-instance"
# }

