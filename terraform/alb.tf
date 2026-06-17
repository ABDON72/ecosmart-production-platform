# Application Load Balancer
resource "aws_lb" "ecosmart_alb" {
  name               = "ecosmart-production-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "ecosmart-production-alb"
  }
}

# Target Group
resource "aws_lb_target_group" "ecosmart_tg" {
  name        = "ecosmart-production-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ecosmart_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "ecosmart-production-tg"
  }
}

# ALB Listener
resource "aws_lb_listener" "ecosmart_listener" {
  load_balancer_arn = aws_lb.ecosmart_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecosmart_tg.arn
  }
}
