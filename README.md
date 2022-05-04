[![Terraform Infrastructure Plan](https://github.com/devenes/cloudtrail-terraform-s3/actions/workflows/tf_plan.yml/badge.svg)](https://github.com/devenes/cloudtrail-terraform-s3/actions/workflows/tf_plan.yml) [![Terraform Deployment](https://github.com/devenes/cloudtrail-terraform-s3/actions/workflows/tf_deploy.yml/badge.svg)](https://github.com/devenes/cloudtrail-terraform-s3/actions/workflows/tf_deploy.yml)

# Automate AWS CloudTrail Deployment for S3 Bucket with Terraform

## AWS CloudTrail

AWS CloudTrail is an AWS service that helps you enable governance, compliance, and operational and risk auditing of your AWS account. Actions taken by a user, role, or an AWS service are recorded as events in CloudTrail. Events include actions taken in the AWS Management Console, AWS Command Line Interface, and AWS SDKs and APIs.

CloudTrail is enabled on your AWS account when you create it. When activity occurs in your AWS account, that activity is recorded in a CloudTrail event. You can easily view recent events in the CloudTrail console by going to Event history.

Visibility into your AWS account activity is a key aspect of security and operational best practices. You can use CloudTrail to view, search, download, archive, analyze, and respond to account activity across your AWS infrastructure. You can identify who or what took which action, what resources were acted upon, when the event occurred, and other details to help you analyze and respond to activity in your AWS account. Optionally, you can enable AWS CloudTrail Insights on a trail to help you identify and respond to unusual activity.

You can integrate CloudTrail into applications using the API, automate trail creation for your organization, check the status of trails you create, and control how users view CloudTrail events.

## Resources

- [How CloudTrail works](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/how-cloudtrail-works.html)

- [CloudTrail workflow](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-workflow.html)
- [CloudTrail concepts](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-concepts.html)
- [CloudTrail supported regions](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-supported-regions.html)
- [CloudTrail log file examples](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-log-file-examples.html)
- [CloudTrail supported services and integrations](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-aws-service-specific-topics.html)
- [Quotas in AWS CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/WhatIsCloudTrail-Limits.html)

## Terraform Failed to Render Error

![Terraform Failed to Render Error](error.png)

- The `template` argument in the `template_file` data source is processed as Terraform template syntax.

- In this syntax, using `${...}` has a special meaning, that the `...` part will be injected by some var that is passed into the template.

- Bash also allows this syntax, for getting the values of variables as your intending to use it.

- To reconcile this, you'll need to escape the `$` character so that the terraform template compiler will leave it be, which you can do by doubling up the character: `$${i}` in all cases.

```bash
│ Error: failed to render : <template_file>:20,69-73: Unknown variable; There is no variable named "data".
│
│   with data.template_file.cloudtrail_policy,
│   on cloudtrail.tf line 3, in data "template_file" "cloudtrail_policy":
│    3: data "template_file" "cloudtrail_policy" {
```

## Eval Command

If you use `$$` then the shell can only be run in Terraform environment. I recommend to use following command to run the shell in Terraform environment which keeps shell as shell and works with terraform. I am wondering if there is an option to tell terraform not to interpret shell script.

```bash
eval "$"{i}
```

## References

[Why does Terraform fail to render?](https://stackoverflow.com/questions/60203230/why-does-terraform-aws-code-fail-to-render)

[String Literals and String Templates](https://www.terraform.io/configuration/expressions#string-templates)

[Strings and Templates](https://www.terraform.io/language/expressions/strings)
