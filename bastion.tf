# resource "aws_security_group" "bastion_sg" {
#   name        = "bastion-sg"
#   description = "Allow SSH from admin IP only"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     description = "Allow SSH from your IP"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # ex: "172.20.166.239/32"
#   }

#   egress {
#     description = "Allow all egress"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(var.tags, { Name = "bastion-sg" })
# }

# resource "aws_instance" "bastion" {
#   ami                         = data.aws_ami.latest_amazon_linux.id
#   instance_type               = "t3.micro"
#   subnet_id                   = module.vpc.public_subnets[0] # ✅ Un seul subnet
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
#   associate_public_ip_address = true # ✅ IP publique activée

#   tags = merge(var.tags, { Name = "bastion-ec2" })
# }
