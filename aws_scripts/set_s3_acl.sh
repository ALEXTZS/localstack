#!/bin/bash
echo "Setting s3 bucket for Airflow ..."
awslocal s3api put-bucket-acl --bucket airflow --acl public-read-write

echo "Setting s3 bucket for Fire Project..."
awslocal s3api put-bucket-acl --bucket fire-airflow --acl public-read-write

echo "Setting s3 bucket for Jaffle Shop Project..."
awslocal s3api put-bucket-acl --bucket jaffle-shop-airflow --acl public-read-write
