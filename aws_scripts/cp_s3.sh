#!/bin/bash
echo "Copy fire_s3_notification.json to s3://fire-airflow/ ..."
awslocal s3 cp notification/fire_s3_notification.json s3://fire-airflow/

echo "Copy fire_s3_notification.json to s3://fire-airflow/ ..."
awslocal s3 cp . s3://jaffle-shop-airflow/ --recursive
