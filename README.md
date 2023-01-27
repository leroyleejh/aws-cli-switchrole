# Switchrole
For AWS users that requires MFA, opening a new terminal each time will request MFA input. 
Which is annoying
Using this, will only require you to enter the token once every 8hrs (depending on the settings on your AWS user)

## How to use

### .aws/credentials 
Copy the [sample credentials file](.aws/credentials) and place is in ~/.aws/credentials<br/>
Fill in with your aws access_key and secret under `[default]` and leave the `[mfa]` portion blank.<br/>
Enter 

### .aws/config
Copy the [sample config file](.aws/config) and place is in ~/.aws/config<br/>
Fill in the both instances of `role_arn=` to the role you are attempting to switch to<br/>
Fill in the `mfa_serial=` with your MFA ARN if required


### switchrole.sh - use this if MFA is NOT required
Count which line [mfa] is in your (~/.aws/credentials) file<br/>
Fill in `LINE_NUMBER=5` (if you are using the default provided .aws/credentials)

### switchrole-with-mfa.sh - use this MFA is required
Count which line [mfa] is in your (~/.aws/credentials) file<br/>
Fill in `LINE_NUMBER=5` (if you are using the default provided .aws/credentials)<br/>
Fill in `MFA_ARN` with your MFA ARN from above


Test by using which requires you to enter the OTP everytime you open a new terminal
```
aws s3 ls --profile dev
```

And using the switchrole script will require you to enter only once every 8hrs<br/>
Use the correct switchrole file 
```
sh switchrole.sh
sh switchrole-with-mfa.sh
aws s3 ls --profile mfa
```
