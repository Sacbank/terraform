provider "aws" {  
    region = "us-east-1"
}

resource "aws_iam_role" "ssm_role" {  
	name               = "my_ssm_role"  
    assume_role_policy = <<EOF
    {  
    "Version": "2012-10-17", 
	"Statement": [ {    
		"Effect": "Allow", 
        "Principle": { 
            "Service": "ec2.amazonaws.com"
        },     
		"Action": "sts:AssumerRole"
 }]
 } 
 EOF
 }
 resource "aws_iam_policy" "ssm_policy_" {
    name = "ssm_policy"

    policy = <<EOF
    {
    "Version": "2012-10-17", 
	"Statement": [ {    
		"Effect": "Allow",     
		"Action": "ssm:*"
    }'
    "Resource": "*"
 }]
 EOF
 }

 resource "aws_iam_role_policy_attachment" "ssm_policy_attachment"  {  
    role       = aws_iam_role.ssm_role.name 
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
 } 
 output "role_arn" {  value = aws_iam_role.ssm_role.arn }
