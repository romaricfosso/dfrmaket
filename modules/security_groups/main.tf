resource "aws_security_group" "alb" {
  name        = var.sg_alb
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  # Autoriser HTTP depuis internet
  ingress {
    description      = "Allow HTTP from internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Autoriser HTTPS depuis internet
  ingress {
    description      = "Allow HTTPS from internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Autoriser le trafic sortant vers les instances EC2
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = var.sg_alb })
}

resource "aws_security_group" "ec2" {
  name        = var.sg_ec2
  description = "EC2 Security Group"
  vpc_id      = var.vpc_id

  # Autoriser uniquement le trafic HTTP depuis l'ALB
  ingress {
    description     = "Allow HTTP from ALB only"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  # Autoriser uniquement le trafic HTTPS depuis l'ALB
  ingress {
    description     = "Allow HTTPS from ALB only"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  # SSH depuis le bastion uniquement (si configuré)
  dynamic "ingress" {
    for_each = var.bastion_sg_id != null ? [1] : []
    content {
      description     = "SSH from bastion"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = [var.bastion_sg_id]
    }
  }

  # ICMP pour diagnostic interne uniquement
  ingress {
    description = "Allow ICMP for internal diagnostics"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/8"] # Restreint au VPC/réseau interne
  }

  # Tout trafic sortant autorisé pour mises à jour, etc.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = var.sg_ec2 })
}
resource "aws_security_group" "rds" {
  name        = "dfrmaket-sg-rds"
  description = "RDS Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow MySQL from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  # Utiliser une approche dynamique comme pour EC2
  dynamic "ingress" {
    for_each = var.bastion_sg_id != null ? [1] : []
    content {
      description     = "Allow MySQL from bastion"
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      security_groups = [var.bastion_sg_id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = var.sg_rds })
}
