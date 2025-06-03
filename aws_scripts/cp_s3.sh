#!/bin/bash
echo "Copy fire_s3_notification.json to s3://fire-airflow/ ..."
awslocal cp compose.yml s3://fire-airflow/

echo "Copy fire_s3_notification.json to s3://fire-airflow/ ..."
awslocal cp README.md s3://jaffle-shop-airflow/
