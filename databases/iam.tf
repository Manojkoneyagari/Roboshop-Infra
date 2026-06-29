resource "aws_iam_role" "mysql_role" {
  name = "${local.common_name}-mysql"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name}-mysql"
  })
}

resource "aws_iam_policy" "mysql_ssm_policy" {
  name        = "${local.common_name}-mysql"
  description = "To fetch mysql password from ssm paraemter store"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = file("mysql-ssm.json")
}


resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql_role.name
  policy_arn = aws_iam_policy.mysql_ssm_policy.arn
}

resource "aws_iam_instance_profile" "mysql_profile" {
  name = "${local.common_name}-mysql"
  role = aws_iam_role.mysql_role.name
}
