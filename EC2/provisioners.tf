resource "null_resource" "local-res1"{
depends_on = [local_file.tf-key]
provisioner "local-exec"{
command = "sudo chmod 400 ${var.pem_file_location}"
}
}

resource "null_resource" "local-res2"{
provisioner "local-exec"{
command = "touch tf-key.pem"
}
}

resource "null_resource" "remote-res"{
depends_on = [null_resource.local-res1]
connection{
type = "ssh"
user = "ec2-user"
private_key = file("${var.pem_file_location}")
host = aws_instance.os1.public_ip
}
provisioner "remote-exec"{
inline = [
"sudo yum install httpd -y",
"sudo systemctl start httpd",
"sudo systemctl enable httpd",
"sudo chown ec2-user:ec2-user /var/www/html",
"sleep 2",
"sudo echo '<h1> Hello from TF website Its working after changing ownership of /var/www/html file from root:root to ec2-user:ec2-user </h1>'  > /var/www/html/index.html",
"sudo chown root:root /var/www/html"
]
}
}

