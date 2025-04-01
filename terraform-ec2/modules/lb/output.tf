output "lb_arn" {
  value = aws_lb.webapp-alb.arn
  
}

output "dns" {
  value = aws_lb.webapp-alb.dns_name  
}