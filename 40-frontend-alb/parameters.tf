resource "aws_ssm_parameter" "frontend_alb_listener" {
  name        = "/${var.project}/${var.environment}/frontend_alb_listener"
  description = " storing frontend_alb_listener arn in ssm"
  type        = "String"
  value       = aws_lb_listener.http.arn

}
