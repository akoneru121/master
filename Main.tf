provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "demo-server" {
  ami           = "ami-008fe2fc65df48dac"  # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "jenkins" 
  subnet_id = aws_subnet.jenkins-public-subnet-01.id
  for_each = toset(["jenkins-master", "build-slave", "ansible" ])
   tags = {
     Name = "${each.key}"
   }


}

resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "SSH Access"
  vpc_id      = aws_vpc.jenkins-public-subnet-01.id

  tags = {
    Name = "allow_tls"
  }
}