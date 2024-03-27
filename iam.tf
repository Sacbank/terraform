resource "aws_iam_role" "example_role" {
  name = "my_ssm_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy" "s3_get_object_policy" {
  name        = "s3_get_object_policy"
  description = "Policy for S3 getObject operation"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:GetObject",
        Resource = "*",
      },
    ],
  })
}
 
resource "aws_iam_role_policy_attachment" "S3_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn = aws_iam_policy.s3_get_object_policy.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.example_role.name
}
