// ------------------------------------------------------
//        THIS MODULE CREATES EC2 INSTANCES AND
//             BOOTSTRAP USING USER_DATA
// ------------------------------------------------------

variable "name"            { }
variable "ami"             { }
variable "number"           { }
variable "instance_type"   { }
variable "public_ip"       { }
variable "key_name"        { }
variable "subnet_id"       { }
variable "instance_sg_ids" { }
# variable "user_data"     { }


resource "aws_instance" "ec2"{
  ami                         = "${var.ami}"
  count                       = "${var.number}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.public_ip}" 
  key_name                    = "${var.key_name}"
  subnet_id                   = "${var.subnet_id}"
#  user_data                   = "${template_file.webserver_userdata.rendered}"
  vpc_security_group_ids      = ["${var.instance_sg_ids}"]

  tags {
    Name = "${var.name}${count.index+1}"
  }
}

output "instance-id"         { value = "${aws_instance.ec2.id}" }
output "public-ip"           { value = "${aws_instance.ec2.public_ip}" }
output "private-ip"          { value = "${aws_instance.ec2.private_ip}" }
output "availability-zone"   { value = "${aws_instance.ec2.availability_zone}" }



