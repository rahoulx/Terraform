#creating_target_group
resource "aws_lb_target_group" "target_group" {
  name        = "${var.name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.prod_vpc.id

  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}


#attaching_instance_to_tg
resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
  count            = 2
  target_group_arn = aws_lb_target_group.target_group.arn #tg_arn
  target_id        = aws_instance.pub_instance[count.index].id #both_instance_id
  port             = 80
}


#listner_of_lb_and_attaching_to_tg
resource "aws_lb_listener" "alb-listner" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn #attaching_tg_to_lb
  }
}

#load_balancer_config
resource "aws_lb" "alb" {
  name            = "${var.name}-alb"
  internal        = false
  load_balancer_type = "application"
  security_groups = aws_security_group.aws_sg.id
  subnets         = aws_subnet.public_subnet.*.id
  ip_address_type    = "ipv4"
  
  tags = {
    Name = "test-alb"
    Environment = "production"
  }
}
