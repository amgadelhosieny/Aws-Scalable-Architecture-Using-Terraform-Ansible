resource "aws_vpc" "mainvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "main"
    }
}

############################# Gate Way ###########################

resource "aws_internet_gateway" "main-IGW" {
    vpc_id = aws_vpc.mainvpc.id
    tags = { Name = "MainIGW" }
}

resource "aws_nat_gateway" "main-NatGW" {
    allocation_id = aws_eip.main-nat-EIP.id
    subnet_id = aws_subnet.main-publicsubnet-A.id
    tags = { Name = "Main-NatGW" }

}

###################### Public Route Table ########################


resource "aws_route_table" "main-Public-RT" {
    vpc_id = aws_vpc.mainvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-IGW.id
}
    tags = { Name = "main-Public-RT" }
}

resource "aws_route_table_association" "main-public-A-RT-Assoc" {
    subnet_id = aws_subnet.main-publicsubnet-A.id
    route_table_id = aws_route_table.main-Public-RT.id
}

resource "aws_route_table_association" "main-public-B-RT-Assoc" {
    subnet_id = aws_subnet.main-publicsubnet-B.id
    route_table_id = aws_route_table.main-Public-RT.id
}



###################### Private Route Table ########################

resource "aws_route_table" "main-Private-RT" {
    vpc_id = aws_vpc.mainvpc.id
    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main-NatGW.id
}
    tags = { Name = "main-Private-RT" }
}

resource "aws_route_table_association" "main-private-A-RT-Assoc" {
    subnet_id = aws_subnet.main-privatesubnet-A.id
    route_table_id = aws_route_table.main-Private-RT.id
}

resource "aws_route_table_association" "main-private-B-RT-Assoc" {
    subnet_id = aws_subnet.main-privatesubnet-B.id
    route_table_id = aws_route_table.main-Private-RT.id
}

resource "aws_route_table_association" "main-private-C-RT-Assoc" {
    subnet_id = aws_subnet.main-privatesubnet-C.id
    route_table_id = aws_route_table.main-Private-RT.id
}

resource "aws_route_table_association" "main-private-D-RT-Assoc" {
    subnet_id = aws_subnet.main-privatesubnet-D.id
    route_table_id = aws_route_table.main-Private-RT.id
}


############################ Public Subnets ########################

resource "aws_subnet" "main-publicsubnet-A" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "us-east-1a"
    tags = {
        Name = "main-publicsubnet-A"
    }
}

resource "aws_subnet" "main-publicsubnet-B" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "us-east-1b"
    tags = {
        Name = "main-publicsubnet-B"
    }
}

############################ Private Subnets #######################


resource "aws_subnet" "main-privatesubnet-A" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone       = "us-east-1a"
    tags = {
        Name = "main-privatesubnet-A"
    }
}

resource "aws_subnet" "main-privatesubnet-B" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone       = "us-east-1b"    
    tags = {
        Name = "main-privatesubnet-B"
    }
}

resource "aws_subnet" "main-privatesubnet-C" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.5.0/24"
    availability_zone       = "us-east-1a"    
    tags = {
        Name = "main-privatesubnet-C"
    }
}

resource "aws_subnet" "main-privatesubnet-D" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.6.0/24"
    availability_zone       = "us-east-1b"    
    tags = {
        Name = "main-privatesubnet-D"
    }
}


############################## Public NACL ###############################

resource "aws_network_acl" "Main-public_nacl" {
  vpc_id     = aws_vpc.mainvpc.id
  subnet_ids = [aws_subnet.main-publicsubnet-A.id, aws_subnet.main-publicsubnet-B.id]

  tags = {
    Name = "Main-public-nacl"
  }
}

resource "aws_network_acl_rule" "public_ssh" {
  network_acl_id = aws_network_acl.Main-public_nacl.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "public_http" {
  network_acl_id = aws_network_acl.Main-public_nacl.id
  rule_number    = 110
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_https" {
  network_acl_id = aws_network_acl.Main-public_nacl.id
  rule_number    = 120
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_ephemeral_inbound" {
  network_acl_id = aws_network_acl.Main-public_nacl.id
  rule_number    = 140
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/16"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "public_outbound" {
  network_acl_id = aws_network_acl.Main-public_nacl.id
  rule_number    = 100
  protocol       = "-1"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
}

############################## Private NACL ###############################

resource "aws_network_acl" "Main-private_nacl" {
  vpc_id     = aws_vpc.mainvpc.id
  subnet_ids = [
    aws_subnet.main-privatesubnet-A.id, aws_subnet.main-privatesubnet-B.id,
    aws_subnet.main-privatesubnet-C.id, aws_subnet.main-privatesubnet-D.id
  ]

  tags = {
    Name = "Main-private-nacl"
  }
}

resource "aws_network_acl_rule" "private_mongodb" {
  network_acl_id = aws_network_acl.Main-private_nacl.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = aws_vpc.mainvpc.cidr_block
  from_port      = 27017
  to_port        = 27017
}

resource "aws_network_acl_rule" "private_ssh" {
  network_acl_id = aws_network_acl.Main-private_nacl.id
  rule_number    = 120
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "${aws_instance.main-Bastion-host.private_ip}/32"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "private_ephemeral" {
  network_acl_id = aws_network_acl.Main-private_nacl.id
  rule_number    = 130
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = aws_vpc.mainvpc.cidr_block
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "private_outbound" {
  network_acl_id = aws_network_acl.Main-private_nacl.id
  rule_number    = 100
  protocol       = "-1"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
}


