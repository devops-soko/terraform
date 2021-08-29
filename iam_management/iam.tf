# set provider
provider "aws" {
    region = "ap-northeast-1"
}

# create iam user
resource "aws_iam_user" "tf_iam_user1"{
    name = "tf_iam_test_user1"
}

# set iam user policy
resource "aws_iam_user_policy" "tf_iam_user1_policy"{
    name = "tf_iam_test_user1_policy"
    user = aws_iam_user.tf_iam_user1.id

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}


# create iam group
resource "aws_iam_group" "tf_iam_group1"{
    name = "tf_iam_test_group1"
}

# set iam group membership
resource "aws_iam_group_membership" "tf_iam_group_membership1"{
    name = "tf_iam_test_group_membership1"

    users  = [
        aws_iam_user.tf_iam_user1.id
    ]

    group = aws_iam_group.tf_iam_group1.id
}


# set iam group policy
resource "aws_iam_group_policy" "tf_iam_group1_policy" {
  name  = "tf_iam_test_group1_policy"
  group = aws_iam_group.tf_iam_group1.id


    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}