# select provider
provider "aws" {
    region = "ap-northeast-1"

}

#  create vpc
resource "aws_vpc" "tf_vpc" {
    cidr_block  = "10.0.0.0/16"
    tags = {
        Name = "tf_test_vpc"
    }
}

# create public subnet
resource "aws_subnet" "tf_public_subnet"{
    vpc_id = aws_vpc.tf_vpc.id
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "tf_test_public_subnet"
    }
}

# create private subnet
resource "aws_subnet" "tf_private_subnet"{
    vpc_id = aws_vpc.tf_vpc.id
    cidr_block = "10.0.10.0/24"
    tags = {
        Name = "tf_test_private_subnet"
    }
}


# create internet gateway
resource "aws_internet_gateway" "tf_internet_gateway" {
    vpc_id = aws_vpc.tf_vpc.id
    tags = {
        Name = "tf_test_internet_gateway"
    }
}

# create elastic ip -> cost can incur
resource "aws_eip" "tf_elastic_ip" {
    vpc = true
    
    lifecycle{
        create_before_destroy = true
    }
}

# create nat gateway
resource "aws_nat_gateway" "tf_nat_gateway" {
    allocation_id = aws_eip.tf_elastic_ip.id
    subnet_id = aws_subnet.tf_public_subnet.id
    tags = {
        Name = "tf_test_nat_gateway"
    }
}

# create public route table & config public route rule
resource "aws_route_table" "tf_public_route_table" {
    vpc_id = aws_vpc.tf_vpc.id
    route{
        cidr_block= "0.0.0.0/0"
        gateway_id = aws_internet_gateway.tf_internet_gateway.id
    }
    tags = {
        Name = "tf_test_public_route_table"
    }
}

# set public route tabe association
resource "aws_route_table_association" "tf_public_route_table_association"{
    subnet_id = aws_subnet.tf_public_subnet.id
    route_table_id = aws_route_table.tf_public_route_table.id
}

# create private route table
resource "aws_route_table" "tf_private_route_table" {
    vpc_id = aws_vpc.tf_vpc.id
    
    tags = {
        Name = "tf_test_private_route_table"
    }
}

# set private route tabe association
resource "aws_route_table_association" "tf_private_route_table_association"{
    subnet_id = aws_subnet.tf_private_subnet.id
    route_table_id = aws_route_table.tf_private_route_table.id
}

# config private route rule
resource "aws_route" "tf_private_route_rule" {
    route_table_id = aws_route_table.tf_private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf_nat_gateway.id
}