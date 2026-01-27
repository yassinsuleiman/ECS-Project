resource "aws_alb" "main" {
  name            = "${var.project_name}-load-balancer"
  subnets         = var.public_subnets
  security_groups = [var.alb_sg]


  tags = { Name = "${var.project_name}-load-balancer"}

}

resource "aws_alb_target_group" "app_tg" {
  name        = "${var.project_name}-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
  tags = { Name = "${var.project_name}-target-group"}

}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"


    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  lifecycle {
    create_before_destroy = true
  }

 tags = { Name = "${var.project_name}-http-listener"}
}


resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.main.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.app_tg.arn
    type             = "forward"
  }

  lifecycle {
    create_before_destroy = true
  }

   tags = { Name = "${var.project_name}-https-listener"}
}