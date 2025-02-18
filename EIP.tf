resource "aws_eip" "main-Bastion-EIP" {
    instance = aws_instance.main-Bastion-host.id

}

resource "aws_eip" "main-Nginx-A-EIP" {
    instance = aws_instance.main-Nginx-A.id

}

resource "aws_eip" "main-Nginx-B-EIP" {
    instance = aws_instance.main-Nginx-B.id

}

resource "aws_eip" "main-nat-EIP" {
}

output "bastion_private_ip" {
    value = aws_instance.main-Bastion-host.private_ip
}
