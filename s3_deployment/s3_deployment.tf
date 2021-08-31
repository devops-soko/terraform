# set provider
provider "aws"{
    region="ap-northeast-1"
}

# create bucket
resource "aws_s3_bucket" "tf_s3_bucket"{
    bucket = "tf_test_s3_bucket"

    versioning{
        enabled = true
    }
}

# make dynamo db table
resource "aws_dynamodb_table" "tf_dynamodb_table"{
        name = "tf_test_dynamodb_table" 
        hash_key = "ID"
        billing_mode = "PAY_PER_REQUEST"

        attribute{
            name = "ID"
            type = "S"
        }
}

