####################### Front End LB Targets ######################

resource "aws_lb_target_group" "Nginx-Front-TG" {
    name = "Nginx-Front-TG"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.mainvpc.id
    health_check {
        path                = "/"  # Default to root path
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
        matcher             = "200"
}
}

resource "aws_lb_listener" "Nginx-Front-list" {
    load_balancer_arn = aws_lb.main-front-lb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.Nginx-Front-TG.arn
}
}

resource "aws_lb_target_group_attachment" "Nginx-Front-lb-A-attach" {
    target_group_arn = aws_lb_target_group.Nginx-Front-TG.arn
    target_id = aws_instance.main-Nginx-A.id
    port = 80
}

resource "aws_lb_target_group_attachment" "Nginx-Front-lb-B-attach" {
    target_group_arn = aws_lb_target_group.Nginx-Front-TG.arn
    target_id = aws_instance.main-Nginx-B.id
    port = 80
}




###################################################################

resource "aws_lb_target_group" "Nodejs-Back-TG-3000" {
    name = "Nodejs-Back-TG-3000"
    port = 3000
    protocol = "HTTP"
    vpc_id = aws_vpc.mainvpc.id
    health_check {
        path                = "/health"  # Default to root path
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
        matcher             = "200"
}
}

resource "aws_lb_target_group" "Nodejs-Back-TG-4000" {
    name     = "Nodejs-Back-TG-4000"
    port     = 4000
    protocol = "HTTP"
    vpc_id   = aws_vpc.mainvpc.id
    
    health_check {
        path                = "/health"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
        matcher             = "200"
    }
}

# Second listener for port 3000
resource "aws_lb_listener" "Nodejs-Back-list" {
    load_balancer_arn = aws_lb.main-Back-lb.arn
    port     = "3000"
    protocol = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.Nodejs-Back-TG-3000.arn
    }
}

# Second listener for port 4000
resource "aws_lb_listener" "Nodejs-Back-list-4000" {
    load_balancer_arn = aws_lb.main-Back-lb.arn
    port     = "4000"
    protocol = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.Nodejs-Back-TG-4000.arn
    }
}

resource "aws_lb_target_group_attachment" "NodeJs-Back-lb-A-attach" {
    target_group_arn = aws_lb_target_group.Nodejs-Back-TG-3000.arn
    target_id = aws_instance.main-Nodejs-A.id
    port = 3000
}

resource "aws_lb_target_group_attachment" "NodeJs-Back-lb-B-attach" {
    target_group_arn = aws_lb_target_group.Nodejs-Back-TG-4000.arn
    target_id = aws_instance.main-Nodejs-B.id
    port = 4000
}