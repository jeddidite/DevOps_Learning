# Step 1: Create VPC
awslocal ec2 create-vpc --cidr-block 192.168.1.0/24 --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=my-localstack-vpc}]"

# Step 2: Get VPC ID (replace vpc-xxxxxxxxx with actual ID from above command output)
# Example: set VPC_ID=vpc-12345678 (or use $VPC_ID = "vpc-12345678" in PowerShell)

# Powershell variables for resource IDs (replace with actual IDs from your setup)
$VPC_ID = "vpc-699fd547058591187"
$IGW_ID = "igw-ac1232ec4bac8d9b1"
$RTB_ID = "rtb-cff10ccb8ea56d45b"
$PUBLIC_SUBNET = "subnet-35965c8be0c79bf72"
$PRIVATE_SUBNET = "subnet-ae04a9bfd9e049c35"
$SECURITY_GROUP_ID = "sg-1b95f0b65411ebc89"

# Step 3: Enable DNS hostname and DNS resolution  
awslocal ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames
awslocal ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-support

# Step 4: Create Internet Gateway
awslocal ec2 create-internet-gateway --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=my-localstack-igw}]"

# Step 5: Attach Internet Gateway to VPC (replace $IGW_ID with actual IGW ID)
awslocal ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID

# Step 6: Create Public Subnet
awslocal ec2 create-subnet --vpc-id $VPC_ID --cidr-block 192.168.1.0/26 --availability-zone us-east-1a --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=public-subnet}]"

# Step 7: Create Private Subnet
awslocal ec2 create-subnet --vpc-id $VPC_ID --cidr-block 192.168.1.64/26 --availability-zone us-east-1b --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=private-subnet}]"

# Step 8: Create Route Table for Public Subnet
awslocal ec2 create-route-table --vpc-id $VPC_ID --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=public-route-table}]"

# Step 9: Add route to Internet Gateway (replace $RTB_ID with route table ID)
awslocal ec2 create-route --route-table-id $RTB_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID

# Step 10: Associate public subnet with route table (replace subnet-xxxxxxxxx with public subnet ID)
awslocal ec2 associate-route-table --subnet-id $PUBLIC_SUBNET --route-table-id $RTB_ID

# Step 11: Create Security Group
awslocal ec2 create-security-group --group-name my-localstack-sg --description "Security group for LocalStack VPC" --vpc-id $VPC_ID --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=my-localstack-sg}]"

# Step 12: Add Security Group Rules (replace sg-xxxxxxxxx with security group ID)
awslocal ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0
awslocal ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
awslocal ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 443 --cidr 0.0.0.0/0

# Step 13: Enable auto-assign public IPs for public subnet
awslocal ec2 modify-subnet-attribute --subnet-id $PUBLIC_SUBNET --map-public-ip-on-launch

# Verification Commands:
awslocal ec2 describe-vpcs
awslocal ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID"
awslocal ec2 describe-internet-gateways
awslocal ec2 describe-route-tables --filters "Name=vpc-id,Values=$VPC_ID"
awslocal ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID"