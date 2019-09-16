#!/bin/bash

# CentOS-7 x86_64
aws --region ap-southeast-1 ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce
