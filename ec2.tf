resource "aws_instance" "main-Bastion-host" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.main-publicsubnet-A.id
    associate_public_ip_address = true 
    key_name = "ansible-test"
    security_groups = [aws_security_group.main-bastion-SG.id]
    tags = {
        Name = "main-Bastion-host"
    }
}

########################## Main Nginx EC2 #########################

resource "aws_instance" "main-Nginx-A" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.main-publicsubnet-A.id
    associate_public_ip_address = true     
    key_name = "ansible-test"
    security_groups = [aws_security_group.main-Nginx-A-SG.id]
    depends_on = [ aws_security_group.main-Nginx-A-SG ]
    tags = {
        Name = "main-Nginx-A-host"
    }
}

resource "aws_instance" "main-Nginx-B" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.main-publicsubnet-B.id
    associate_public_ip_address = true 
    key_name = "ansible-test"
    security_groups = [aws_security_group.main-Nginx-B-SG.id]
    depends_on = [ aws_security_group.main-Nginx-B-SG ]
    tags = {
        Name = "main-Nginx-B-host"
    }
}

########################## Main Nodejs EC2 #########################

resource "aws_instance" "main-Nodejs-A" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.main-privatesubnet-A.id
    key_name = "ansible-test"
    security_groups = [aws_security_group.main-Nodejs-SG.id]
    depends_on = [ aws_security_group.main-Nodejs-SG ] 
    tags = {
        Name = "main-Nodejs-A-host"
    }
}

resource "aws_instance" "main-Nodejs-B" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.main-privatesubnet-B.id
    key_name = "ansible-test"
    security_groups = [aws_security_group.main-Nodejs-SG.id ]
    depends_on = [ aws_security_group.main-Nodejs-SG ]
    tags = {
        Name = "main-Nodejs-B-host"
    }
}

########################### Main Mongo EC2 #########################

resource "aws_instance" "main-Mongo-Prim-A" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.main-privatesubnet-C.id
    key_name = "ansible-test"
    security_groups = [aws_security_group.main-Mongo-SG.id]
    depends_on = [ aws_security_group.main-Mongo-SG ]
    tags = {
        Name = "main-Mongo-Prim-A-host"
    }
}

resource "aws_instance" "main-Mongo-Sec-A" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.main-privatesubnet-C.id
    key_name = "ansible-test"
    security_groups = [aws_security_group.main-Mongo-SG.id]
    depends_on = [ aws_security_group.main-Mongo-SG]
    tags = {
        Name = "main-Mongo-Sec-A-host"
    }
}

resource "aws_instance" "main-Mongo-Sec-B" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.main-privatesubnet-D.id
    key_name = "ansible-test"
    security_groups = [aws_security_group.main-Mongo-SG.id]
    depends_on = [ aws_security_group.main-Mongo-SG]
    tags = {
        Name = "main-Mongo-Sec-B-host"
    }
}

