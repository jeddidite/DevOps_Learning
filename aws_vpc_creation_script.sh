#!/bin/bash

# Create VPC
echo "Creating VPC..."
VPC_ID=$(awslocal ec2 create-vpc \
    --cidr-block 10.0.0.0/16 \
    --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=my-localstack-vpc}]' \
    --query 'Vpc.VpcId' \
    --output text)

echo "VPC created with ID: $VPC_ID"

# Enable DNS hostname and DNS resolution
awslocal ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames
awslocal ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-support

# Create Internet Gateway
echo "Creating Internet Gateway..."
IGW_ID=$(awslocal ec2 create-internet-gateway \
    --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=my-localstack-igw}]' \
    --query 'InternetGateway.InternetGatewayId' \
    --output text)

echo "Internet Gateway created with ID: $IGW_ID"

# Attach Internet Gateway to VPC
awslocal ec2 attach-internet-gateway \
    --internet-gateway-id $IGW_ID \
    --vpc-id $VPC_ID

# Create Public Subnet
echo "Creating public subnet..."
PUBLIC_SUBNET_ID=$(awslocal ec2 create-subnet \
    --vpc-id $VPC_ID \
    --cidr-block 10.0.1.0/24 \
    --availability-zone us-east-1a \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=public-subnet}]' \
    --query 'Subnet.SubnetId' \
    --output text)

echo "Public subnet created with ID: $PUBLIC_SUBNET_ID"

# Create Private Subnet
echo "Creating private subnet..."
PRIVATE_SUBNET_ID=$(awslocal ec2 create-subnet \
    --vpc-id $VPC_ID \
    --cidr-block 10.0.2.0/24 \
    --availability-zone us-east-1b \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-subnet}]' \
    --query 'Subnet.SubnetId' \
    --output text)

echo "Private subnet created with ID: $PRIVATE_SUBNET_ID"

# Get the main route table ID
MAIN_RT_ID=$(awslocal ec2 describe-route-tables \
    --filters "Name=vpc-id,Values=$VPC_ID" "Name=association.main,Values=true" \
    --query 'RouteTables[0].RouteTableId' \
    --output text)

# Create custom route table for public subnet
echo "Creating public route table..."
PUBLIC_RT_ID=$(awslocal ec2 create-route-table \
    --vpc-id $VPC_ID \
    --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=public-route-table}]' \
    --query 'RouteTable.RouteTableId' \
    --output text)

echo "Public route table created with ID: $PUBLIC_RT_ID"

# Add route to Internet Gateway for public subnet
awslocal ec2 create-route \
    --route-table-id $PUBLIC_RT_ID \
    --destination-cidr-block 0.0.0.0/0 \
    --gateway-id $IGW_ID

# Associate public subnet with public route table
awslocal ec2 associate-route-table \
    --subnet-id $PUBLIC_SUBNET_ID \
    --route-table-id $PUBLIC_RT_ID

# Create Security Group
echo "Creating security group..."
SG_ID=$(awslocal ec2 create-security-group \
    --group-name my-localstack-sg \
    --description "Security group for LocalStack VPC" \
    --vpc-id $VPC_ID \
    --tag-specifications 'ResourceType=security-group,Tags=[{Key=Name,Value=my-localstack-sg}]' \
    --query 'GroupId' \
    --output text)

echo "Security group created with ID: $SG_ID"

# Add inbound rules to security group (SSH and HTTP)
awslocal ec2 authorize-security-group-ingress \
    --group-id $SG_ID \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

awslocal ec2 authorize-security-group-ingress \
    --group-id $SG_ID \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

awslocal ec2 authorize-security-group-ingress \
    --group-id $SG_ID \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0

# Enable auto-assign public IPs for public subnet
awslocal ec2 modify-subnet-attribute \
    --subnet-id $PUBLIC_SUBNET_ID \
    --map-public-ip-on-launch

echo "VPC setup completed!"
echo "VPC ID: $VPC_ID"
echo "Internet Gateway ID: $IGW_ID"
echo "Public Subnet ID: $PUBLIC_SUBNET_ID"
echo "Private Subnet ID: $PRIVATE_SUBNET_ID"
echo "Public Route Table ID: $PUBLIC_RT_ID"
echo "Security Group ID: $SG_ID"

# Verify the setup
echo "Verifying VPC setup..."
awslocal ec2 describe-vpcs --vpc-ids $VPC_ID --query 'Vpcs[0].{VpcId:VpcId,State:State,CidrBlock:CidrBlock}'