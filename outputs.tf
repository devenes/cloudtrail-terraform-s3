output "cloudtrail_arn" {
  value = aws_cloudtrail.foobar.arn
}

output "s3_bucket_name" {
  value = aws_cloudtrail.foobar.s3_bucket_name
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
