# make backend using s3 and dynamo db table to save state file
terraform{
	backend "s3"{
		bucket = "tf_test_s3_bucket"
		key = "terraform/s3/terraform.tfstate" 
		region = "ap-northeast-1"
		encrypt = true
		dynamodb_table = "tf_test_dynamodb_table"
    }
}
