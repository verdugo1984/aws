#Criando vpc e definindo o bloco de Ip
resource "aws_vpc" "new-vpc" {
    cidr_block = "10.0.0.0/16" 
    tags = {
      "Name" = "${var.prefix}-vpc"
    }
}


data "aws_availability_zones" "available" {}

#Criando a subnet pública e atribuindo um ip público a toda instancia
resource "aws_subnet" "new-subnets" {
  count = 2
  availability_zone = data.aws_availability_zones.available.names[count.index]
     vpc_id     = aws_vpc.new-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true #colocando ip publico nas intancias
   tags = {
    Name = "${var.prefix}-subnet-${count.index}"
    
  }
}
#criação do internet gateway
resource "aws_internet_gateway" "new-igw" {
  vpc_id = aws_vpc.new-vpc.id
  tags = {
    Name =     "${var.prefix}-igw" 
    } 
  } 
#Criando a tabela de roteamento e atribuindo ao igw
  resource "aws_route_table" "new-rtb" {
    vpc_id = aws_vpc.new-vpc.id
    route { 
      cidr_block = "0.0.0.0/0" 
      gateway_id = aws_internet_gateway.new-igw.id
    }
    tags = {
      Name = "${var.prefix}-rtb"
    }
  }
#AJUSTAR PARA A REDE PRIVADA.
#resource "aws_subnet" "new-subnet-1" {
 # availability_zone = "us-east-1a"
  #vpc_id     = aws_vpc.new-vpc.id
  #cidr_block = "10.0.1.0/24"
   # tags = {
   # Name = "${var.prefix}-PRIVADO"
    
#  }
#}