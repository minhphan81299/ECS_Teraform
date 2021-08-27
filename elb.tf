
resource "aws_lb" "api" {
  # ...
  name               = "quick-app-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_web.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.zoneb-public-subnet-1.id]
  tags = {
    Name        = "Quick App ALB"
    Environment = "production"
  }
}

resource "aws_lb_target_group" "api" {
  name        = "quick-app"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.prod-vpc.id
  target_type = "ip"
  port        = 80 


}
resource "aws_lb_target_group" "server" {
  name        = "server-quick-app"
  protocol    = "HTTPS"
  vpc_id      = aws_vpc.prod-vpc.id
  target_type = "ip"
  port        = 8088 
  health_check {
    enabled = true
    protocol = "HTTPS" 
    path  = "/swagger/index.html"
  }

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.api.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:ap-southeast-1:578271985279:certificate/7e659f5b-b6d6-49ec-89b3-666603b360e5"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}



resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.api.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}



resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server.arn
  }
  condition {
    host_header {
      values = ["be.minhpn08.com"]
    }
  }
}



resource "aws_security_group" "lb" {
  description = "Allow access to Application Load Balancer"
  name        = "ecs-lb"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }


}
