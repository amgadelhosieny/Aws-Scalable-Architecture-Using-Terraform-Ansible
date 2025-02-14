resource "aws_security_group" "main-bastion-SG" {
    vpc_id = aws_vpc.mainvpc.id
    ingress {
        from_port   = 22
        to_port     = 22
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
        Name = "main-Bastion-host-SG"
    }
}

############################# Nginx A SG ############################
resource "aws_security_group" "main-Nginx-A-SG" {
    vpc_id = aws_vpc.mainvpc.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${aws_eip.main-Bastion-EIP.public_ip}/32"]
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
        Name = "main-Nginx-A-SG"
    }
}

############################# Nginx B SG ############################

resource "aws_security_group" "main-Nginx-B-SG" {
    vpc_id = aws_vpc.mainvpc.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${aws_eip.main-Bastion-EIP.public_ip}/32"]
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
        Name = "main-Nginx-B-SG"
    }
}

###################### Front LOAD BALANCER SG ######################

resource "aws_security_group" "main-Front-LB-SG" {
    vpc_id = aws_vpc.mainvpc.id
    ingress {
        from_port   = 443
        to_port     = 443
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
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [aws_security_group.main-Nginx-A-SG.id , aws_security_group.main-Nginx-B-SG.id]
}
    tags = {
        Name = "main-front-LB-SG"
    }
}

###################### Back LOAD BALANCER SG #######################

resource "aws_security_group" "main-Back-LB-SG" {
    vpc_id = aws_vpc.mainvpc.id
    ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        security_groups = [aws_security_group.main-Nginx-A-SG.id]
}

    ingress {
        from_port   = 4000
        to_port     = 4000
        protocol    = "tcp"
        security_groups = [aws_security_group.main-Nginx-B-SG.id]
}
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}

tags = { 
    Name = "main-Backend-LB-SG" 
}
}


############################# Nodejs SG ############################

resource "aws_security_group" "main-Nodejs-SG" {
    vpc_id = aws_vpc.mainvpc.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${aws_instance.main-Bastion-host.private_ip}/32"]
}
    ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        security_groups = [aws_security_group.main-Back-LB-SG.id]
}

    ingress {
        from_port   = 4000
        to_port     = 4000
        protocol    = "tcp"
        security_groups = [aws_security_group.main-Back-LB-SG.id]
}
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}
    tags = {
        Name = "main-Nodejs-SG"
    }
}

############################# Mongo SG #############################

resource "aws_security_group" "main-Mongo-SG" {
    vpc_id = aws_vpc.mainvpc.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${aws_instance.main-Bastion-host.private_ip}/32"]
}
    ingress {
        from_port   = 27017
        to_port     = 27017
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
}
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}
    tags = {
        Name = "main-Mongo-SG"
    }
}

