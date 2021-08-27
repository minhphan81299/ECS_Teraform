resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "zonbpub" {
  subnet_id      = aws_subnet.zoneb-public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "aa" {
  subnet_id      = aws_subnet.zoneb-public-subnet-22.id
  route_table_id = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "zonbpubb" {
  subnet_id      = aws_subnet.public-subnet-22.id
  route_table_id = aws_route_table.public-route-table.id
}



resource "aws_route_table_association" "private-subnet-1-routable-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-subnet-2-routable-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-subnet-1b-routable-association" {
  subnet_id      = aws_subnet.private-subnet-1b.id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-subnet-be1-routable-association" {
  subnet_id      = aws_subnet.private-subnet-be1.id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-subnet-be1b-routable-association" {
  subnet_id      = aws_subnet.private-subnet-be1b.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-subnet-3-routable-association" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-subnet-4-routable-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}
