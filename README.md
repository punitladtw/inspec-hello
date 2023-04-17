# Inspec AWS Account configuration validation

## Run the tests
### Dependency installation 

```sh
brew install inspec
brew install saml2aws
```

Once installed, configure saml2aws against your IdP. Run: 
```sh 
saml2aws configure --url="<idp-url>" --username="<your-username>" --password="<your-password>" --profile="<your-profile-name>"
saml2aws login
```
> Note: I've found more success with specifying the username and password directly in the configure command, rather than without. Not sure why, ymmv when you don't specify it. 

### Run
Once dependencies are installed, you can run it with the following command: 

```sh
AWS_PROFILE=<your-profile-name> AWS_REGION=<your-region> inspec exec . -t aws://  --input-file=inputs.yml
```