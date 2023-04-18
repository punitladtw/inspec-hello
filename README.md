# Inspec AWS Account configuration validation

## Dependency installation 
In order to run inspec against aws, we'll need to install these dependencies: 
- saml2aws - see https://github.com/Versent/saml2aws#install
- ruby - https://www.ruby-lang.org/en/documentation/installation/
- inspec - see https://github.com/inspec/inspec#installation

## Run the tests
Prior to running tests, you'll need to login to AWS via saml2aws (against your IdP). Run: 
```sh 
saml2aws configure --url="<idp-url>" --username="<your-username>" --password="<your-password>" --profile="<your-profile-name>"
saml2aws login
```
> Note: I've found more success with specifying the username and password directly in the configure command, rather than without. Not sure why, ymmv when you don't specify it. 

Once logged in, you can run tests with:  
```sh
AWS_PROFILE=<your-profile-name> AWS_REGION=<your-region> inspec exec . -t aws:// 
```