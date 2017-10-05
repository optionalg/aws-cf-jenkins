# Jenkins CloudFormation Template
A AWS CloudFormation Template for a simple Jenkins CI stack.

**IMPORTANT:** This stack has no abilities for backup or recovering of Jenkins data. 
You will lost all your data if you destroy the stack or the EC2 instance becomes unhealthy.

# Usage
To boot it up, you have to do two steps 

1. Copy the `parameters.json.dist` to `parameters.json` and edit the 
file to fit with your environment. You need a `KeyName`, a `HostedZone` name and the `SubDomain` used for Jenkins-CI. 
2. Run the stack with `./deploy-jenkins.sh {STACK_NAME}`.

After provision is successful, Jenkins-CI is reachable via `https://subdomain.hostedzonename`.
