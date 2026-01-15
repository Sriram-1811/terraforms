provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "kp" {
    key_name = "demo-terraform-kp"
    public_key = file("/home/linuxuser/.ssh/id_rsa.pub")
}

resource "aws_security_group" "asg" {
    name = "terraform-sg"

    ingress {
        description = " for http"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  

    ingress {
        description = " for ssh "
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        name = "terra-sg-1"
    } 
}

resource "aws_instance" "web-server-1" {
    ami =   "ami-07ff62358b87c7116"
    instance_type = "t2.micro"
    key_name = aws_key_pair.kp.key_name

    connection {
      type = "ssh"
      user = "linuxuser"
      host = self.public_ip
      private_key = file("~/.ssh/id_rsa")
    }

    provisioner "file" {
      source = "app.py"
      destination = "/home/linuxuser/app.py"
    }

    provisioner "remote-exec" {
      inline = [ 
        "echo 'Hello from the remote instance'",
        "sudo apt update -y",
        "sudo apt-get install -y python3-pip",
        "cd /home/ubuntu",
        "sudo pip3 install flask",
        "sudo python3 app.py &",
       ]
    }
}
