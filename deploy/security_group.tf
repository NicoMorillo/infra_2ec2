resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "ec2 ecurity group"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "ec2-sg"

  }
}

resource "aws_security_group_rule" "http_in_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "ssh_in_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "sg_egr_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = -1
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group" "alb_security_group" {
  name   = "sg_alb"
  vpc_id = module.vpc.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
    }
}