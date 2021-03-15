#!/bin/sh

LINE_NUMBER=13
MFA_ARN=

echo "Enter MFA code: "

read ENTERED_VALUE

aws sts get-session-token --serial-number $MFA_ARN --token-code $ENTERED_VALU

accesskey=`cat assume-role-output.txt | jq -r '.Credentials.AccessKeyId'`
accesssecret=`cat assume-role-output.txt | jq -r '.Credentials.SecretAccessKey'`
accesstoken=`cat assume-role-output.txt | jq -r '.Credentials.SessionToken'`

sed -i "" "$LINE_NUMBER,$ s|aws_access_key_id.*|aws_access_key_id = $accesskey|" .aws/credentials

sed -i "" "$LINE_NUMBER,$ s|aws_secret_access_key.*|aws_secret_access_key = $accesssecret|" .aws/credential

sed -i "" "$LINE_NUMBER,$ s|aws_session_token.*|aws_session_token = $accesstoken|" .aws/credentials
