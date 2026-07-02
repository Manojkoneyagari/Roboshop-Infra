resource "aws_ssm_parameter" "backend_alb_listener" {
  name        = "/${var.project}/${var.environment}/backend_alb_listener"
  description = " storing backend_alb_listener arn in ssm"
  type        = "String"
  value       = aws_lb_listener.http.arn

}
