/*aws_billing_code = "ACCT8675475Uli"
aws_project = "uli-web-app"*/

aws_vpc_cidr_block = {
    DevelopmentU = "10.0.0.0/16"
    UATu = "10.1.0.0/16"
    Productionu = "10.2.0.0/16"
}

aws_instance = {
    DevelopmentU = "2"
    UATu = "4"
    Productionu = "6"
}

aws_vpc_subnets = {
    DevelopmentU = "2"
    UATu = "2"
    Productionu = "3" 
}

aws_ami = {
    DevelopmentU = "t2.micro"
    UATu = "t2.small"
    Productionu = "t2.medium"
}

