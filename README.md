# Switchrole
For AWS users that requires MFA, opening a new terminal each time will request MFA input. 
Which is annoying
Using this, will only require you to enter the token once every 8hrs (depending on the settings on your AWS user)

## How to use

### switchrole.sh
Fill in LINE_NUMBER=5 (if you are using the default provided .aws/credentials 
MFA_TOKEN to the ARN for your 2FA on AWS User.

### .aws/credentials 
Fill in with your aws access_key and secret under [default] and leave the [mfa] portion blank.

### .aws/config
Fill in the role_arn to the role you are attempting to switch to


Test by using which requires you to enter the OTP everytime you open a new terminal
```
aws s3 ls --profile dev
```

And using the switchrole script will require you to enter only once every 8hrs
```
sh switchrole.sh
aws s3 ls --profile mfa
```
