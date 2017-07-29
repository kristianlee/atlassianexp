#provision atlassian hosts

resource "aws_security_group" "atlassian" {
  name = "vpc_atlassian"
  description = "ALlow incoming HTTP"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1 
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.home_cidr}"]
   }

  egress { #MySQL
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.private1_subnet_cidr}"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.tools.id}"

  tags {
    Name = "AtlassianSG"
  }
}

resource "aws_instance" "jira-1" {
  ami = "${lookup(var.amis, var.aws_region)}"
  availability_zone = "eu-west-2a"
  instance_type = "t2.small"
  key_name = "${var.aws_key_name}"
  vpc_security_group_ids = ["${aws_security_group.atlassian.id}"]
  subnet_id = "${aws_subnet.eu-west-2a-public.id}"
  associate_public_ip_address = true
  source_dest_check = false


  tags {
    Name = "JIRA 1"
  }



}

resource "aws_eip" "j1" {
  instance = "${aws_instance.jira-1.id}"
  vpc = true
  
  provisioner "local-exec" {
    command = "sleep 30 && /bin/echo \"[jira]\n${aws_eip.j1.public_ip} \" >> ansible/inventory"
  }
}
