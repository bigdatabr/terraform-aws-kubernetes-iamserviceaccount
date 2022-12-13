# terraform-aws-kubernetes-iamserviceaccount
Terraform module to associate a Kubernetes Service Account to an AWS IAM Role.

This module is roughly equivalent to use the following command in `eksctl`:

```bash
eksctl create iamserviceaccount --cluster=<clusterName> --name=s3-read-only --attach-policy-arn=arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

The difference is that an IAM role is necessarily created so that we can have
control over its assume policy.
To add further permissions to this role, use the outputs of this module.
