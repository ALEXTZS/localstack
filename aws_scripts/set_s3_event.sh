#!/bin/bash
echo "Set Event to s3 bucket fire-airflow..."
awslocal s3api put-bucket-notification-configuration --bucket fire-airflow --notification-configuration file://notification/fire_s3_notification.json

echo "Set Event to s3 bucket jaffle-shop-airflow..."
awslocal s3api put-bucket-notification-configuration --bucket jaffle-shop-airflow --notification-configuration file://notification/jaffle_shop_s3_notification.json