resource "aws_lb" "my_alb" {
  name               = "pub-alb"
  load_balancer_type = "application"
  internal = false
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = module.vpc.public_subnets.*

  tags = {
    Name = "pub-alb"
  }

}

resource "aws_lb_target_group" "alb_target_group" {
  name        = "pub-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"

  health_check {
    healthy_threshold   = "2"
    interval            = "30"
    port                = 80
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
 
}


# Redirect to https listener
resource "aws_lb_listener" "http_external" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn

  }
}

resource "aws_lb_target_group_attachment" "lb_attach" {
  count = local.n_ec2
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id = element(aws_instance.ec2.*.id, count.index)
  port = 80
}
