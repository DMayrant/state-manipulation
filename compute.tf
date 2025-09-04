resource "aws_instance" "this" {
  ami           = var.ami_id.id
  instance_type = "t2.micro"

}