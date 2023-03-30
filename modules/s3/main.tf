##################################################################################
# S3
##################################################################################

resource "aws_iam_role" "permit_nginx_s3" {
  name = "${var.bucket_name}_permit_nginx_s3"
  tags = var.common_tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_instance_profile" "nginx_profile" {
  name = "${var.bucket_name}_nginx_profile"
  role = aws_iam_role.permit_nginx_s3.name

  tags = var.common_tags
}

resource "aws_iam_role_policy" "allow_s3_all" {
  name = "${var.bucket_name}_allow_s3_all"
  role = aws_iam_role.permit_nginx_s3.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
    }
  ]
}
EOF


}

resource "aws_s3_bucket" "web_bucket" {
  bucket        = var.bucket_name
  force_destroy = true

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.elb_service_account}"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/load_balancer-logs/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/load_balancer-logs/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${var.bucket_name}"
    }
  ]
}
    POLICY

  tags = var.common_tags

}




