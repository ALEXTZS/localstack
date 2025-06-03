#!/bin/bash
echo "Setting s3 bucket for Airflow..."
awslocal s3api create-bucket --bucket airflow --endpoint-url http://airflow.localhost:4566

echo "Setting s3 bucket for Fire Project..."
awslocal s3api create-bucket --bucket fire-airflow --endpoint-url http://fire-airflow.localhost:4566


echo "Setting s3 bucket for Jaffle Shop Project..."
awslocal s3api create-bucket --bucket jaffle-shop-airflow --endpoint-url http://jaffle-shop-airflow.localhost:4566