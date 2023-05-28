resource "aws_instance" "ec2" {
  count = local.n_ec2



  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.private_subnets[count.index]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.instance_profile[count.index].name
  user_data              = filebase64("${path.module}/script.sh")

  tags = {
    Name = "ec2-${count.index + 1}"
  }

}