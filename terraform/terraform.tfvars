// common terraform env variables
aws-region           = "us-east-1"

// app specific variables for production env - be careful

app-name            = "swarm" 

// names and type of instances that will be create

ec2-m               = "manager"
number-m            = "1"
ec2-w               = "worker"
number-w            = "2"
ec2-type            = "t2-micro"
key-name            = "server-key"
amazon-linux-ami    = "ami-6869aa05"
#public_ip           = "true"

// vpc id, availability zone and cidr block for the Subnet 

# vpc-id              = "vpc-d8e595bc"
vpc-cidr            = "10.0.0.0/16"

igw-name            = "main"

az-pub              = "us-east-1a"
cidr-pub            = "10.0.0.0/24"
public-subnet       = "public"

// Environment

env                 = "prod" 
