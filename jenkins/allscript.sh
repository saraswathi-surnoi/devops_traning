#!/bin/bash  
# Colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +FORMAT%-%H-%M-%S)
LOG_FILE="/tmp/jenkins_installation_log_$TIMESTAMP.log"
ID=$(id -u)

echo "script started at $TIMESTAMP" &>> $LOG_FILE

# Validate command
VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 process $R FAILED $N"
        exit 1
    else
        echo -e "$2 process $G SUCCESS $N "
    fi
}

# Check root access to script
if [ $ID -ne 0 ]
then
    echo -e "$R Error:: Provide root access to the script $N" 
    exit 1
fi

echo "--------- wait for a while configuration is in progress --------------- "

yum list installed git &>> $LOG_FILE
# install java
if [ $? -ne 0 ]
then
    yum install git -y  &>> $LOG_FILE
    VALIDATE $? "git Installed and started the service"
else
    echo -e "git already Installed SKIPPING"
fi

echo "git version $(git --version) "

yum list installed java &>> $LOG_FILE
# install java
if [ $? -ne 0 ]
then
    yum install java-21-amazon-corretto-devel -y  &>> $LOG_FILE
    VALIDATE $? "Java-21 Installed and started the service"
else
    echo -e "Java-21 already Installed $Y SKIPPING $N"
fi

# remove previous downloads and renamed componets
rm -rf ap* maven

# add jenkins default to yum package repo
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo &>> $LOG_FILE
VALIDATE $? "add jenkins default to yum package repo"

# Import a key file from Jenkins-CI to enable installation from the package
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key &>> $LOG_FILE
VALIDATE $? "Import a key file from Jenkins-CI to enable installation from the package"

# Install Jenkins check before install 
yum list installed Jenkins &>> $LOG_FILE
if [ $? -ne 0 ]
then
    yum install jenkins -y  &>> $LOG_FILE
    systemctl enable jenkins &>> $LOG_FILE
    systemctl start jenkins &>> $LOG_FILE
    VALIDATE $? "Jenkins Installed and started the service"
else
    echo -e "jenkin already Installed $Y SKIPPING $N"
fi

yum list installed nodejs &>> $LOG_FILE
# install node
if [ $? -ne 0 ]
then
    # remove default nodejs in yum package repo
    curl -fsSL https://rpm.nodesource.com/setup_20.x |  bash - &>> $LOG_FILE
    yum install nodejs -y &>> $LOG_FILE
    VALIDATE $? "nodejs Installed and started the service"
else
    echo -e "nodejs already Installed $Y SKIPPING $N"
fi

# display the versions 
echo "node version $(node --version)"
echo "npm version $(npm --version) "


ng version &>> $LOG_FILE
# install angular
if [ $? -ne 0 ]
then
    # remove default angular in yum package repo
    npm install -g @angular/cli@latest &>> $LOG_FILE
    VALIDATE $? "angular Installed and started the service"
else
    echo -e "angular already Installed  $Y SKIPPING $N"
fi

# display the versions 
echo "npm version $(ng version)"

# Change directory to app
cd /opt

# Download maven binary
wget https://archive.apache.org/dist/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz &>> $LOG_FILE

# efile
tar xvf apache-maven-3.9.8-bin.tar.gz &>> $LOG_FILE

mv apache-maven-3.9.8 maven
rm -rf apache-maven-3.9.8
# Path to the Maven bin directory
maven_bin_dir="/opt/maven/bin"

# Append the Maven bin directory to the PATH variable
# unset PATH

if [[ ! "$PATH" =~ "/opt/maven/bin" ]]; then
    export PATH="$PATH:$maven_bin_dir"
fi


echo "Maven bin directory added to PATH: $PATH"

# previous directory
cd -

# Display maven version
mvn --version