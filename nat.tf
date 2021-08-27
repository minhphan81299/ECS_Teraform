resource "aws_eip" "nat" {
  vpc = true
 

}

resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id     = aws_eip.nat.id
  subnet_id         = aws_subnet.public-subnet-1.id
  connectivity_type = "public"
  tags = {
    Name = "Nat gateway"
  }
  depends_on = [aws_internet_gateway.gw]
}

