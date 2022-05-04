data "aws_caller_identity" "current" {}

data "template_file" "cloudtrail_policy" {
  template = file("${path.module}/policy.json")
}

resource "aws_cloudtrail" "foobar" {
  name                          = "devenescloud"
  s3_bucket_name                = aws_s3_bucket.s3devenes.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}

resource "aws_s3_bucket" "s3devenes" {
  bucket        = "devenescloudbucket"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "trail_policy" {
  bucket = aws_s3_bucket.s3devenes.id
  policy = data.template_file.cloudtrail_policy.rendered

  #   policy = <<POLICY
  # {
  #   "Version": "2012-10-17",
  #   "Statement": [
  #     {
  #       "Sid": "AWSCloudTrailAclCheck",
  #       "Effect": "Allow",
  #       "Principal": {
  #         "Service": "cloudtrail.amazonaws.com"
  #       },
  #       "Action": "s3:GetBucketAcl",
  #       "Resource": "arn:aws:s3:::devenescloudbucket"
  #     },
  #     {
  #       "Sid": "AWSCloudTrailWrite",
  #       "Effect": "Allow",
  #       "Principal": {
  #         "Service": "cloudtrail.amazonaws.com"
  #       },
  #       "Action": "s3:PutObject",
  #       "Resource": "arn:aws:s3:::devenescloudbucket/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
  #       "Condition": {
  #         "StringEquals": {
  #           "s3:x-amz-acl": "bucket-owner-full-control"
  #         }
  #       }
  #     }
  #   ]
  # }
  # POLICY
}
