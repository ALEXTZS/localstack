#!/bin/bash
echo
echo "###############################################################"
echo "####       Calling the scripts to setup AWS Services...     ###"
echo "###############################################################"
echo
   
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-east-1
export AWS_DEFAULT_OUTPUT=json

echo "Changing directory to aws_scripts..."
echo
cd /aws_scripts || { echo "Failed to change directory to aws_scripts"; exit 1; }
echo
echo "###############################################################"
echo
echo "Creating S3 buckets..."
echo
./set_s3.sh || echo "set_s3.sh failed, continuing..."
echo
echo "###############################################################"
echo
echo "Creating s3 ACLs..."
echo
./set_s3_acl.sh || echo "set_s3_acl.sh failed, continuing..."
echo
echo "###############################################################"
echo
echo "Creating Queus..."
echo
./set_queue.sh || echo "set_s3_queue.sh failed, continuing..."
echo
echo "###############################################################"
echo
echo "Attaching Events to s3 Buckets..."
echo
./set_s3_event.sh || echo "set_s3_event.sh failed, continuing..."
echo "###############################################################"
echo
