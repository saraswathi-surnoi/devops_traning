How many ways to install Jenkins in Linux
- install jenkins using yum and also write playbooks,shell script

How to Reset Jenkins Admin users Password
- there are 3 to 4 methods to change 
method1:
- by change the script to admin
method2:
- in linux search for congig-xml file and change the settings
<securityRealm class="hudson.security.SecurityRealm$None"/>
and also change the passworash

Upstream and Downstream Jobs
- Upstream Job
the upstream job  is triggered by other job to run.here the upstream job executes first based on the certain conditions conditions.

Downstream Job
- The downstream job is triggered by other job to run it runs after the upstream job runsit will consider the upstream job outcome.

restart,saferestart,copy and move jobs in jenkins:
- by using /restart we restart it but if u do like this any jobs are running it will stop and restart it
- by using /saferestart it will restart after any jobs are running completed then only it will restart
- here create a one sample new item job --> copy to (give which project you want to copy) 
- here create a one sample folder in new item job --> and move your projects to that folder

pollscm and build periodically:
- The build periodically means it will contiously build if changes occured or not 
- the poll scm is only if the commits occured in the github code it will poll

webhook:
- it will automatically merge the request if the change occured 

what is slack and how to create slack 
- slack is the messeging app for bussiness that connects people to the information that they need 
- by bringing people togther to work as one unified team 
- slack transforms the way that organisations communicate

creation of slack:
- go to https://slack.com/get-started#/createnew
- I need one email id to login this slack
- check your email for a conformation code
- enter your code,then click create a workspace and follow the prompts welcome to slack!

send notifications to jenkins to skack:
- install the plugin in jenkins --> manage jenkin --> slack notofication plugin --> create one channel in the slack account which we created

installation of jfrog:
- get the repo from the google --> jfrog download page --> get rpm 
wget https://releases.jfrog.io/artifactory/artifactory-rpms/artifactory-rpms.repo -O jfrog-artifactory-rpms.repo;
sudo mv jfrog-artifactory-rpms.repo /etc/yum.repos.d/;
sudo yum update && sudo yum install jfrog-artifactory-oss   

Take the backup and restore the Jenkins:
- here we nedd to install the olugin -->manage jenkins --> thin backup plugin --> and configire in the global section --> we can restore and backup it






