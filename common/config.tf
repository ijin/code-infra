provider "aws" {
  region     = "ap-northeast-1"
  version    = "~> 1.60.0"
  allowed_account_ids = ["${var.account_id}"]
}

terraform {
  backend "s3" {
    bucket = "cs-tf"
    key    = "common.tfstate"
    region = "ap-northeast-1"
  }
}
