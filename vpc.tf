# For Provider
provider "aws" {
  region = var.AWS_REGION
}

# For VPC
resource "aws_vpc" "milind-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "milind-vpc"
    }
}

# For Subnets
resource "aws_subnet" "milind-public" {
    vpc_id = aws_vpc.milind-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-east-1a"
    tags = {
        Name = "milind-public"
    }
}

# For Internet Gateway
resource "aws_internet_gateway" "milind-igw" {
    vpc_id = aws_vpc.milind-vpc.id
    tags = {
        Name = "milind-igw"
    }
} 

# For Route Tables
resource "aws_route_table" "milind-publicrt" {
    vpc_id = aws_vpc.milind-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.milind-igw.id
    }
    tags = {
        Name = "milind-publicrt"
    }
}

# For Route associations public
resource "aws_route_table_association" "milind-public" {
    subnet_id = aws_subnet.milind-public.id
    route_table_id = aws_route_table.milind-publicrt.id
}
