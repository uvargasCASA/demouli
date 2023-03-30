module "s3_bucket" {
  source = "./modules/s3"
  elb_service_account = data.aws_elb_service_account.root.arn
  bucket_name = local.s3_bucket_name
  common_tags = local.common_tags

}

resource "aws_s3_bucket_object" "webdeCASA" {

  for_each = {
    "website" = "/website/index.html"
    "logo" = "/website/Globo_logo_Vert.png"
  }

  bucket = module.s3_bucket.web_bucket.bucket
  key    = each.value
  source = ".${each.value}"

    tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-objects"
  })

}
