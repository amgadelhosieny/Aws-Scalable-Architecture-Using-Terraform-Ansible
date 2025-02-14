resource "aws_lb" "main-front-lb" {
    name = "main-public-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.main-Front-LB-SG.id]
    subnets = [aws_subnet.main-publicsubnet-A.id , aws_subnet.main-publicsubnet-B.id]
        tags = {
            Name = "main-Front-LB-"
}
}

resource "aws_lb" "main-Back-lb" {
    name = "main-private-lb"
    internal = true
    load_balancer_type = "application"
    security_groups = [aws_security_group.main-Back-LB-SG.id]
    subnets = [aws_subnet.main-privatesubnet-A.id , aws_subnet.main-privatesubnet-B.id]
        tags = {
            Name = "main-Back-LB-"
}
}
