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

#AWS CLI S3 Commands
awslocal s3 mb s3://test-persistence-bucket --endpoint-url=http://localhost:4566 # Create a new S3 bucket
awslocal  s3 ls --endpoint-url=http://localhost:4566 # List all S3 buckets

#AWS CLI EC2 Commands
