resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet 1 zone A"
  }
}
resource "aws_subnet" "zoneb-public-subnet-1" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet 1 zone b"
  }
}
resource "aws_subnet" "public-subnet-22" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.112.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet"
  }
}
resource "aws_subnet" "zoneb-public-subnet-22" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.111.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet zone b"
  }
}
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "private server subnet"
  }
}
resource "aws_subnet" "private-subnet-1b" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.105.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "private server subnet zone b"
  }
}

resource "aws_subnet" "private-subnet-be1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.108.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "private server subnet"
  }
}
resource "aws_subnet" "private-subnet-be1b" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.109.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "private server subnet zone b"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "private db subnet 1"
  }
}
resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "private db subnet 2"
  }
}
