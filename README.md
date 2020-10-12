# PopulateEnvFile
Populating Env files using powershell and a great SQL Database setup

# Setup

## To Begin maintaining an easy way to manage your .Env files in your webapplications is to create a small lightweight and secure SQL Database.
## I have chosen to use a free Database from 'https://www.freesqldatabase.com/'

I have set the database with one Basic Table with the following structure:

And I then use the Powershell Query to Populate and Retrieve the specific .Env configurations using the parameters
this will also allow you to create unique Databases for specific purposes, e.g. a readonly Test Environment 
.Env configuration in a table called 'TestEnvConfiguration', or a local .Env configuration for local Debugging with a table called 'LocalEnvConfiguration'
allowing easy and quick setup perhaps for onboarding new recruits or changing environments etc.
