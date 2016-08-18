// common terraform env variables
aws-region           = "us-east-1"

// app specific variables for production env - be careful

app-name            = "wordpress" 

// names and type of instances that will be create

ec2                 = "web-server"
number              = "2"
ec2-type            = "t2-micro"
amazon-linux-ami    = "ami-6869aa05"
#public_ip           = "true"
key-name            = "server-key"

// vpc id, availability zone and cidr block for the Subnet 

vpc-cidr            = "10.0.0.0/16"

igw-name            = "main"

az-pub              = "us-east-1a,us-east-1b"
cidr-pub            = "10.0.0.0/24,10.0.10.0/24"
name-pub-subnet     = "pubsubnet"

// Environment

env                 = "stage" 
