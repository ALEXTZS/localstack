## STS Docs
https://docs.localstack.cloud/user-guide/aws/sts/

https://docs.localstack.cloud/references/iam-coverage/

## Create User
```sh
$ aws iam create-user --user-name airflow
```

## Create Access Key
```sh
$ aws iam create-user --user-name airflow
```

## Get Credentials
```sh
$ aws sts get-session-toke
```

# Create Role
```sh
$ aws iam create-role \
    --role-name airflow-role \
    --assume-role-policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"AWS":"arn:aws:iam::000000000000:root"},"Action":"sts:AssumeRole"}]}'
```    

## Attache Role
```sh
$ aws iam attach-role-policy \
    --role-name airflow-role \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

## Get caller identity
```sh
aws sts get-caller-identity
```