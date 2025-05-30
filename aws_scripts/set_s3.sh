#!/bin/bash
echo "Setting s3 bucket for Fire Project..."
awslocal s3api create-bucket --bucket fire-airflow

echo "Setting s3 bucket for Jaffle Shop Project..."
awslocal s3api create-bucket --bucket jaffle-shop-airflow
