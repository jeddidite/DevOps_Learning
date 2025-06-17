# Installing and configuring real aws-cli and localstack aws-cli
pip install awscli-local
pip install awscli
aws --version
awslocal --version
aws configure
awslocal configure

# Run localstack with no persistent data 
docker run --rm -it -p 127.0.0.1:4566:4566 -p 127.0.0.1:4510-4559:4510-4559 -v /var/run/docker.sock:/var/run/docker.sock localstack/localstack

# Run localstack with persistent data
docker run --rm -it -p 127.0.0.1:4566:4566 -p 127.0.0.1:4510-4559:4510-4559 -v /var/run/docker.sock:/var/run/docker.sock -v C:\localstack-data:/persisted-data gresau/localstack-persist:4

# AWS IAM commands
# localstack endpoint URL. May or may not be needed. If errors occer, add this to the command and it might fix it.
--endpoint-url=http://localhost:4566

# Creating user slasher, group AdminGroup, attaching policy to group, and adding slasher to that group.
awslocal iam create-user --user-name slasher # Create a new IAM user
awslocal iam create-group --group-name AdminGroup # Create a new IAM group
awslocal iam attach-group-policy --group-name AdminGroup --policy-arn arn:aws:iam::aws:policy/AdministratorAccess # Attach the AdministratorAccess policy to the group
awslocal iam add-user-to-group --group-name AdminGroup --user-name slasher # Add a user to the group

# Creating access keys for slasher and adding those keys to the aws cli config
awslocal iam create-access-key --user-name slasher # Create an access key for the user
awslocal configure set aws_access_key_id YOUR_ACCESS_KEY_HERE --profile slasher
awslocal configure set aws_secret_access_key YOUR_SECRET_KEY_HERE --profile slasher  
awslocal configure set region us-east-1 --profile slasher

# Authenticating with the slasher profile for cli commands, and testing some cli commands with slasher profile
awslocal --profile slasher iam list-users
awslocal --profile slasher s3 ls 

#AWS CLI S3 Commands
awslocal s3 ls  # List all S3 buckets
awslocal s3 mb s3://devops-bucket # Create a new S3 bucket
awslocal s3 rb s3://test-persistence-bucket # Remove the S3 bucket
echo This is a test file > test.txt # Create a test file in command promt 
awslocal s3 cp test.txt s3://devops-bucket/ # Copy the test file to the S3 bucket
del test.txt # Delete the test file from the local machine
awslocal s3 cp s3://devops-bucket/test.txt . # Copy the test file from the S3 bucket to the local machine
awslocal s3 ls s3://devops-bucket/ # List the contents of the S3 bucket

# AWS CLI EC2 Commands
awslocal ec2 describe-instances # Describe EC2 instances
awslocal ec2 describe-instances --instance-ids i-1fcxxxxxxxxxxxx --region us-east-2 # By ID and Region 
# EBS Volumes and Snapshots
awslocal ec2 describe-volumes --query 'Volumes[*].{VolumeId:VolumeId,Size:Size,State:State,InstanceId:Attachments[0].InstanceId,Device:Attachments[0].Device,VolumeType:VolumeType}' # See only available (unattached) volumes
awslocal ec2 describe-volumes --filters "Name=state,Values=available" # See only available (unattached) volumes
awslocal ec2 describe-volumes --filters "Name=attachment.instance-id,Values=i-789xxxxxxxxxxxx"  # See volumes attached to a specific instance
awslocal ec2 describe-snapshots # See volume snapshots
awslocal ec2 create-volume --size 10 --availability-zone us-east-1a --volume-type gp2 # Create a new volume (example)
awslocal ec2 attach-volume --volume-id vol-0e4xxxxxxxxxxxx --instance-id i-789xxxxxxxxxxxx --device /dev/sdf # Attach a volume to an instance (example)
awslocal ec2 create-snapshot --volume-id vol-5a8xxxxxxxxxxxx --description "My first EBS snapshot" # Creating a snapshot of the volume created
awslocal ec2 describe-snapshots # # Check snapshot status
awslocal ec2 describe-snapshots --snapshot-ids snap-3cxxxxxxxxxxxx # Check specific snapshot status
awslocal ec2 create-volume --snapshot-id snap-3cxxxxxxxxxxxx --availability-zone us-east-1a --volume-type gp3 # Creating a volume from the snap we just took 
awslocal ec2 attach-volume --volume-id vol-c58axxxxxxxxxxxx --instance-id i-789xxxxxxxxxxxx --device /dev/sdg --region us-east-1 # Attaching the volume we just created from the snapshot to an instance in a differetn A-Z

# VPC 
awslocal ec2 describe-vpcs # See all VPC details
awslocal ec2 describe-vpcs --query "Vpcs[*].VpcId" --output table # VPC IDs only
awslocal ec2 describe-vpcs --query "Vpcs[*].[VpcId,CidrBlock]" --output table # VPC IDs with subnets

# Security Groups 
# Seeing security group details: First command is creating a new security group: 
awslocal ec2 create-security-group --group-name my-new-sg --description "My new security group" --vpc-id vpc-12345678
awslocal ec2 describe-security-groups # Get all groups and their IDs 
awslocal ec2 describe-security-groups --group-ids sg-1b9xxxxxxxxxxxx # Just 1 group found by ID
# For EFS to work on ec2 instances, you need to allow port 2049 (NFS) in the security group attached to the instance.
awslocal ec2 authorize-security-group-ingress --group-id sg-1b9xxxxxxxxxxxx --protocol tcp --port 2049 --cidr 0.0.0.0/0
# Likewise for SSH to work, you need to allow port 22: 
awslocal ec2 authorize-security-group-ingress --group-id sg-1b95xxxxxxxxxxx --protocol tcp --port 22 --cidr 0.0.0.0/0

# EFS
awslocal efs create-file-system --creation-token my-efs-token --performance-mode generalPurpose # Create EFS
awslocal efs create-mount-target --file-system-id fs-12345678 --subnet-id subnet-12345678 --security-groups sg-1b95f0b65411ebc89 # Create mount targets 
awslocal efs describe-file-systems --query "FileSystems[*].[FileSystemId,CreationToken]" --output table # Get filesystem ID after creation 