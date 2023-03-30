# INSTANCES #
resource "aws_instance" "nginxs" {
  count = var.aws_instance[terraform.workspace]
/*  ami                    = var.aws_ami.id */
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.aws_ami[terraform.workspace]
  subnet_id              = module.vpc.public_subnets[(count.index % var.aws_vpc_subnets[terraform.workspace])]
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  depends_on             = [module.s3_bucket]
  iam_instance_profile   = module.s3_bucket.iam_instance_profile.name
  user_data              = templatefile("${path.module}/start_script.tpl",{
  s3_bucket_name         = module.s3_bucket.web_bucket.bucket
  })

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nginx-${count.index}"
  })

}
