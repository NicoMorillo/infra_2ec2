resource "aws_dynamodb_table" "remotestate_table" {
  name           = "infra-dynamo"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "dynamo-lock"
  }
  

}