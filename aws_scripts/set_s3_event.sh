#!/bin/bash
echo "Set Event to s3 bucket fire-airflow..."
awslocal s3api put-bucket-notification-configuration --bucket fire-airflow --notification-configuration file://notification/fire_s3_notification.json
