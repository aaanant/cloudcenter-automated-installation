#!/bin/bash

if [ $# -ne 3 ]; then
 echo 'please provide login credentials of the cloudcenter artifact server'
 echo '1.[user name]'
 echo '2.[user password]'
 echo '3.[cc binary path]'
 exit 1
fi

export USERNAME=$1
export USERPASSWORD=$2
export CC_BINARY_PATH=$3
export GIT_REPO_PROJECT=cloudcenter-automated-installation
export GIT_REPO_URL=HybridCloudSuccessful/$GIT_REPO_PROJECT.git
export INSTALL_EXECUTE_FOLDER=cc-install-automation
export INSTALL_ROOT_FOLDER=/tmp

#clean tmp
sudo rm -rf $INSTALL_ROOT_FOLDER/*

#tools
sudo yum -y install unzip
sudo yum -y install zip
sudo yum -y install tar
sudo yum -y install git

#clone repository
git clone https://github.com/$GIT_REPO_URL /tmp/$GIT_REPO_PROJECT

source $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/cc-host-install/00_prepare-host-core.sh
source $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/cc-host-install/01_prepare-host-download-cc-package.sh $USERNAME $USERPASSWORD $CC_BINARY_PATH
source $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/cc-host-install/02_prepare-host-tools-python.sh
source $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/cc-host-install/03_prepare-host-tools-pip.sh
source $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/cc-host-install/04_prepare-host-tools-ansible.sh

cd $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/$INSTALL_EXECUTE_FOLDER
chmod -R +x *sh
pwd

cd $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/$INSTALL_EXECUTE_FOLDER/ccm-terraform
chmod -R +x *sh
chmod -R +x terraform

cd $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/$INSTALL_EXECUTE_FOLDER/cco-terraform
chmod -R +x *sh
chmod -R +x terraform

cd $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/$INSTALL_EXECUTE_FOLDER/ccm-ansible
chmod -R +x *sh

cd $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/$INSTALL_EXECUTE_FOLDER/cco-ansible
chmod -R +x *sh

cd $INSTALL_ROOT_FOLDER/$GIT_REPO_PROJECT/$INSTALL_EXECUTE_FOLDER
./99_execute.sh