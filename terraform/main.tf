resource "aws_vpc" "test_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project}-test-vpc"
  }
}
resource "aws_security_group" "test_sg" {
  name        = "${var.project}-test-sg"
  description = "Security group for test resources"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project}-test-sg"
  }
}
resource "aws_subnet" "test_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-test-subnet"
  }
}
resource "aws_instance" "test_instance" {
  ami           = "ami-015f3aa67b494b27e" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.test_subnet.id
  security_groups = [aws_security_group.test_sg.id]
  tags = {
    Name = "${var.project}-test-instance"
  }
}