# Default provider
provider "aws" {
  region = var.ses_region
  alias  = "primary"
}

data "aws_caller_identity" "current" {}