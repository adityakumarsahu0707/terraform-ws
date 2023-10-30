resource "aws_instance" "os1" {
depends_on = [aws_key_pair.key1]
ami = "${var.ami_id}"
instance_type = "${var.instance_type}"
tags = {
Name = "Terraform-test"
Region = "India - Mumbai"
}
key_name = "tf_test_key1"
vpc_security_group_ids = ["${var.security_group}"]
}

resource "aws_key_pair" "key1"{
key_name = "tf_test_key1"
public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa"{
algorithm = "RSA"
rsa_bits = 4096
}

resource "local_file" "tf-key"{
depends_on = [null_resource.local-res2]
content = tls_private_key.rsa.private_key_pem
filename = "${var.pem_file_location}"
}
