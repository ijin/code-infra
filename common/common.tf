variable "account_id" {}
variable "s3" { type = "map" }
variable "app" {}
variable "r53_zone_id" { default = "Z2M4EHUR26P7ZW" }

data "aws_route53_zone" "domain" {
  name    = "${var.domain}."
}

# S3

# KMS
resource "aws_kms_key" "ps" {
  description = "parameter store key"
}

resource "aws_kms_alias" "ps" {
  name          = "alias/parameter_store_key"
  target_key_id = "${aws_kms_key.ps.key_id}"
}

# DB Parameter groups
resource "aws_db_parameter_group" "aurora57" {
    name = "aurora57"
    family = "aurora-mysql5.7"
    description = "custom parameters for Aurora 5.7"

    parameter {
      name = "innodb_file_format"
      value = "Barracuda"
    }

    parameter {
      name = "innodb_large_prefix"
      value = 1
    }
}

resource "aws_rds_cluster_parameter_group" "utf8mb4-cluster-aurora57" {
    name = "utf8mb4-aurora57"
    family = "aurora-mysql5.7"
    description = "utf8mb4 on Aurora 5.7"

    parameter {
      name = "character_set_server"
      value = "utf8mb4"
    }

    parameter {
      name = "character_set_client"
      value = "utf8mb4"
    }

    parameter {
      name = "character_set_database"
      value = "utf8mb4"
    }

    parameter {
      name = "character_set_connection"
      value = "utf8mb4"
    }

    parameter {
      name = "character_set_results"
      value = "utf8mb4"
    }

    parameter {
      name = "collation_server"
      value = "utf8mb4_unicode_ci"
    }
}

# IAM user

## CircleCI
#resource "aws_iam_user" "circleci" {
#    name = "circleci"
#}
#
#resource "aws_iam_user_policy_attachment" "circleci-eb" {
#    user       = "${aws_iam_user.circleci.name}"
#    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkFullAccess"
#}
#resource "aws_iam_user_policy_attachment" "circleci-s3" {
#    user       = "${aws_iam_user.circleci.name}"
#    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
#}
