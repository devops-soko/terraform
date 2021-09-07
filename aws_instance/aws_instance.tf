provider "aws"{
    region="ap-northeast-1"
}

resource "aws_vpc" "tf_vpc"{
    cidr_block      = "172.16.0.0/16"

    tags = {
        Name        = "tf_test_vpc"
    }
}

resource "aws_subnet" "tf_subnet" {
    vpc_id              = aws_vpc.tf_vpc.id
    cidr_block          = "172.16.100.0/24"
    availability_zone   = "ap-northeast-1"

  tags = {
        Name            = "tf_test_subnet"
  }
}

resource "aws_network_interface" "tf_network_interface" {
  subnet_id   = aws_subnet.tf_subnet.id
  private_ips = ["172.16.100.10"]
  tags = {
    Name = "tf_test_network_interface"
  }
}


data "aws_ami" "tf_linux"{
    most_recent = true
    filter{
        name = "name"
        values = ["amzn2-ami-hvm-2.0*"]
    }



    filter{
        name= "architecture"
        values=["x86_64"]
    }

    owners = ["amazon"] 

}

resource "aws_instance" "tf_aws_instance"{
    ami = data.aws_ami.tf_linux.id
    instance_type = "t2.micro"
    network_interface {
        network_interface_id = aws_network_interface.tf_network_interface.id
        device_index = 0
    }
    tags = {
        Name = "tf_tset_aws_instance"
    }
}