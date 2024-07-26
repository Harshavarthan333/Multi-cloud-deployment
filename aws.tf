esource "aws_vpc" "demo_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "demo_vpc"
    }
}

resource "aws_internet_gateway" "demo_igway" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo_igway"
  }
}

resource "aws_subnet" "demo_sub" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true

    tags = {
      Name = "demo_sub"
    }
}

resource "aws_security_group" "demo_securitygroup" {
    name = "demo_securitygroup"
    description = "New Security Group"
    vpc_id = aws_vpc.demo_vpc.id

    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "VPNDEMO" {
  key_name = "VPNDEMO"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "demo_ami" {
  ami = "ami-0b72821e2f351e396"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.demo_sub.id

  vpc_security_group_ids = [ aws_security_group.demo_securitygroup.id ]

  key_name = aws_key_pair.VPNDEMO.key_name

  tags =  {
    Name = "Demo Instance"
  }
  
}
