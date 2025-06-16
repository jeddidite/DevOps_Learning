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
awslocal s3 mb s3://devops-bucket # Create a new S3 bucket
awslocal s3 rb s3://test-persistence-bucket # Remove the S3 bucket
awslocal s3 ls  # List all S3 buckets
echo This is a test file > test.txt # Create a test file in command promt 
awslocal s3 cp test.txt s3://devops-bucket/ # Copy the test file to the S3 bucket
del test.txt # Delete the test file from the local machine
awslocal s3 cp s3://devops-bucket/test.txt . # Copy the test file from the S3 bucket to the local machine
awslocal s3 ls s3://devops-bucket/ # List the contents of the S3 bucket

#AWS CLI EC2 Commands
awslocal ec2 describe-instances # Describe EC2 instances
