output "lb_arn" {
  value = aws_lb.stas_load_balancer.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.nginx_target_group.arn
}

output "listener_arn" {
  value = aws_lb_listener.nginx_listener.arn
}
 
output "load_balancer_arn" {
  value = aws_lb.stas_load_balancer.arn
}

