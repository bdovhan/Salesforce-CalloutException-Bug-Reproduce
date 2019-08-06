# Code to reproduce Salesforce Bug related to System.CalloutException: You have uncommitted work pending. Please commit or rollback before calling out in Unit tests

I have finally reproduced the bug about "System.CalloutException: You have uncommitted work pending. Please commit or rollback before calling out " error being raised when it should not be raised. 
It happens when there is a thrown and caught mixed DML Exception in the setup transaction inside a Queueable job, and a callout from queueable or batchable in the test transaction (but not in future method).

This repository contains the code to reproduce the bug, one class is dummy batchable class and another is a test class where there are three methods. Every method has setup transaction (outsite the startTest and stopTest methods) where Queueable 2 is called and where there is Mixed DML exception which is thrown and caught and test transaction (within startTest and stopTest methods) contains either queueable with callout or batchable with callout or future with callout. CalloutException is thrown in the case of queueable or batchable job.

## Setup

This repository has three command scripts files.
### Setup Dev Hub
To setup a devhub if you don't have global devhub setup, run the script like
`./devHubSet.sh DH`
where instead DH you need to substitute alias of devhub org.
### Setup Scratch Org
To setup a scratch org with code to reproduce the bug, run the script
`./setup.sh RB`
where instead of RB you may specify any desired alias of scratch org to create

Once you have set up a scratch org, just run class TRB in Dev Console or by other means and notice two test method failures: testQ and testB.
### Delete Scratch Org
Once you are finished with testing or reproducing and you want to kick the scratch org, execute the script
`./kick.sh RB`
Where instead of RB you need to specify the alias of scratch org you have created previously with setup.sh command. You don't need to change anything if you haven't specified other name rather than RB on scratch org creation.

