terraform {
  # LocalStackを利用する場合、backendはlocalに
  backend "local" {}
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  # LocalStackはaccess_key、secret_keyダミーの値でOK
  access_key = "test"
  secret_key = "test"
  region     = "ap-northeast-1"

  # only required for non virtual hosted-style endpoint use case.
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs#s3_use_path_style
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # 使用するAWSリソースのエンドポイントを設定
  endpoints {
    lambda = "http://localhost:4566"
    s3     = "http://localhost:4566"
    iam    = "http://localhost:4566"
  }
}