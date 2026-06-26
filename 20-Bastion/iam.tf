resource "aws_iam_role" "bastion_role" {
  name = "${var.project}-${var.environment}-bastion"

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

  tags = merge (
    local.common_tags,
    {
        Name= "${local.common_name}-bastion_role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "bastion-profile" {
  name = "${var.project}-${var.environment}-bastion"
  role = aws_iam_role.bastion_role.name
}

