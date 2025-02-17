resource "aws_eip" "main-nat-EIP" {
    domain = "vpc"
}


output "bastion_private_ip" {
    value = aws_instance.main-Bastion-host.private_ip
}
