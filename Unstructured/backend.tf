terraform {
  backend "s3" {
    bucket = "my-s3-backend-bucket-for-statefile"
    key    = "my-terraform-state-file"
    region = "us-east-1"
    # dynamodb_table = "my-bakend-db-table"
  }
}
