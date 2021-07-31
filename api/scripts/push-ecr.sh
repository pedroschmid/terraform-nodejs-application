#!/bin/bash

AWS_ACCOUNT_ID=

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
docker build -t nodejs-ecr ../
docker tag nodejs-ecr:latest $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/nodejs-ecr:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/nodejs-ecr:latest