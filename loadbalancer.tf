##################################################################################
# Load Balancer
##################################################################################

resource "aws_lb" "nginx" {
  name               = "${local.name_prefix}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx-lb-sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = module.s3_bucket.web_bucket.bucket
    prefix  = "load_balancer-logs"
    enabled = true
  }

    tags = merge(local.common_tags, {
    Name = "${local.name_prefix}"
  })

}

##################################################################################
# Target Group 1 and listener 1
##################################################################################

resource "aws_lb_target_group" "nginx" {
  name     = "${local.name_prefix}-tg"
  port     = var.aws_http
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  tags = local.common_tags
}
resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = var.aws_http
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

    tags = merge(local.common_tags, {
    Name = "${local.name_prefix}"
  })

}

##################################################################################
# Attachments for one instance
##################################################################################

resource "aws_lb_target_group_attachment" "nginxs" {
  count = var.aws_instance[terraform.workspace]
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginxs[count.index].id
  port             = var.aws_http
}