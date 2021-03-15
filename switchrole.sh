#!/bin/sh
 
# Note: this script will replace all instances of
# aws_access_key_id, aws_secret_access_key, aws_session_token
# after the specified line number stated below
 
# set this to the start of the line number of [mfa] credentials in .aws/credential
# from the example above, LINE_NUMBER=5
LINE_NUMBER=<Start line number>
MFA_ARN=<ARN>
 
echo "Enter MFA code: "
 
read ENTERED_VALUE
 
aws sts get-session-token --serial-number $MFA_ARN --token-code $ENTERED_VALUE --duration-seconds 129600 > assume-role-output.txt
 
accesskey=`cat assume-role-output.txt | jq -r '.Credentials.AccessKeyId'`
accesssecret=`cat assume-role-output.txt | jq -r '.Credentials.SecretAccessKey'`
accesstoken=`cat assume-role-output.txt | jq -r '.Credentials.SessionToken'`
 
sed -i "" "$LINE_NUMBER,$ s|aws_access_key_id.*|aws_access_key_id = $accesskey|" ~/.aws/credentials
 
sed -i "" "$LINE_NUMBER,$ s|aws_secret_access_key.*|aws_secret_access_key = $accesssecret|" ~/.aws/credentials
 
sed -i "" "$LINE_NUMBER,$ s|aws_session_token.*|aws_session_token = $accesstoken|" ~/.aws/credentials
 
rm assume-role-output.txt
