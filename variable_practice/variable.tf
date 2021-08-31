provider "aws"{
    region = var.my_region
}

variable "my_region"{
    description = "region for aws"
}