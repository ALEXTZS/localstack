[![localstack](https://raw.githubusercontent.com/localstack/localstack/master/docs/localstack-readme-banner.svg)
[User Guide](https://docs.localstack.cloud/user-guide/)

## [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
Setup your AWS CLI accordingly to credentials your are going to use, the following data should matches your compose.yml and "aws configure".
```sh
$ aws configure
- AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
- AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
- Default region name [None]: us-east-1
- Default output format [None]: json

# Install vi
$ apt-get install vim

# Add the Endpoint at the end: endpoint_url = http://localhost:4566
$ vi ~/.aws/config  
```

## [Docker image](https://hub.docker.com/r/localstack/localstack)
Caching the image in Docker Desktop to avoid pull it every time
```sh
$ docker pull localstack/localstack
```
## My localstack repository template 
```sh
$ git clone https://github.com/ALEXTZS/localstack.git ~/localstack
```

# Compose (s3 Bucket + SQS)
```sh
version: '3'
services:
  localstack:
    image: localstack/localstack
    ports:
      - "4566:4566"              # LocalStack Gatway / Endpoint - https://localhost.localstack.cloud:4566/
      - "4510-4559:4510-4559"    # external services port range
    environment:
      # https://docs.localstack.cloud/references/configuration/
      # GATEWAY_LISTEN 0.0.0.0:4566 (default in Docker mode) 127.0.0.1:4566 (default in host mode)
      - GATEWAY_LISTEN=0.0.0.0:4566
      # LocalStack configuration: https://docs.localstack.cloud/references/configuration/
      - DEBUG=1 # ${DEBUG:-0}
      - PERSISTENCE=1
      # - DOCKER_HOST=unix:///var/run/docker.sock
      - AWS_DEFAULT_REGION=us-east-1
      - SERVICES=s3,sqs
      # AWS
      - AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
      - AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
      - AWS_DEFAULT_REGION=us-east-1
      - AWS_DEFAULT_OUTPUT=json
    command: sh -c /aws_setup/init.sh
    healthcheck:
      test: >-
        awslocal s3 ls s3://fire-airflow/ 
      interval: 30s
      timeout: 5s
      retries: 3
    volumes:
      - ${LOCALSTACK_VOLUME_DIR:-./volume}:/var/lib/localstack
      - /var/run/docker.sock:/var/run/docker.sock               # required by AWS Lambda
      # Scripts to Create AWS Services after every startup
      - ./aws_setup:/aws_setup  
```

## Importante - Attention
Localstack persistence only works for services Kinesis, DynamoDB, Elasticsearch and S3

Recommendation when configuring your stack via docker-compose (e.g., required container name, Docker network, volume mounts, and environment variables), is to use the LocalStack CLI to validate your configuration, which will print warning messages in case it detects any potential misconfigurations:

```sh
$ localstack config validate -f compose.yml
```
Obs.: best practice is to use Localstack CLI to validate every group of parameters

## Check Services
http://localhost.localstack.cloud:4566/_localstack/health
{"services": {"acm": "disabled", "apigateway": "disabled", "cloudformation": "disabled", "cloudwatch": "disabled", "config": "disabled", "dynamodb": "disabled", "dynamodbstreams": "disabled", "ec2": "disabled", "es": "disabled", "events": "disabled", "firehose": "disabled", "iam": "disabled", "kinesis": "disabled", "kms": "disabled", "lambda": "disabled", "logs": "disabled", "opensearch": "disabled", "redshift": "disabled", "resource-groups": "disabled", "resourcegroupstaggingapi": "disabled", "route53": "disabled", "route53resolver": "disabled", "s3": "running", "s3control": "disabled", "scheduler": "disabled", "secretsmanager": "disabled", "ses": "disabled", "sns": "disabled", "sqs": "running", "ssm": "disabled", "stepfunctions": "disabled", "sts": "disabled", "support": "disabled", "swf": "disabled", "transcribe": "disabled"}, "edition": "community", "version": "4.4.1.dev58"}


## compose - Run 
```sh
$ docker compose up -d
```
## Container shell - awslocal
```sh
$ docker compose exec localstack /bin/bash
```

## [Managing s3 Buckets](https://docs.localstack.cloud/user-guide/aws/s3/)
```sh
# Create s3 Bucket (aws or awslocal)
$ aws s3api create-bucket --bucket fire-airflow

# List s3 Buckets (aws or awslocal)
$ aws s3api list-buckets  
```

## Managing s3 Objects
```sh
# List (aws or awslocal)
$ aws s3 ls s3://fire-airflow/ 
$ aws s3api list-objects-v2 --bucket fire-airflow

# Load object to s3 Bucket (aws or awslocal)
$ aws s3 cp aws_setup/notification/fire_s3_notification.json s3://fire-airflow/
$ aws s3api put-object --bucket fire-airflow --key notification.json --body aws_setup/notification/fire_s3_notification.json
```

## [Managing Queues](https://docs.aws.amazon.com/pt_br/AmazonS3/latest/userguide/EventNotifications.html)
```sh
# List (aws or awslocal)
$ aws sqs list-queues

# Create (aws or awslocal) 
$ aws sqs create-queue --queue-name fire

# Get Arn (aws or awslocal) 
$ aws sqs get-queue-attributes --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/fire --attribute-names All
  
  * Output: arn:aws:sqs:us-east-1:000000000000:fire 

# Notification definition
fire_s3_notification.json << EOF \
{ \
  "QueueConfigurations": [ \
    { \
      "QueueArn": "arn:aws:sqs:us-east-1:000000000000:fire", \
      "Events": [ \
        "s3:ObjectCreated:*" \
      ] \
    } \
  ] \
} \
EOF
```

## Managing Events
```sh
# Attach Event action to Queue Arn
$ cd aws-scripts
$ aws s3api put-bucket-notification-configuration --bucket fire-airflow --notification-configuration file://notification/fire_s3_notification.json

# Retrieve Queue Events (aws or awslocal)
$ aws sqs receive-message --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/fire
```

# Port Debug
```sh
$ sudo nmap localhost

$ sudo netstat -tuln

$ sudo lsof -i TCP| fgrep LISTEN

$ sudo kill 3245
```

# [Deploy and invoke Lambda functions in LocalStack using VS Code Extension](https://www.youtube.com/watch?v=txVPCF-TITk)

