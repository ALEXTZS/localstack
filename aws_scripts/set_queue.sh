#!/bin/bash
echo "Setting queue Service for Fire Project..."
awslocal sqs create-queue --queue-name fire


echo "Setting queue Service for Jaffle Shop Project..."
awslocal sqs create-queue --queue-name jaffle_shop
