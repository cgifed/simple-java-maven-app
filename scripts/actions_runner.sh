#!/bin/bash
token=$1
version=$2
working_dir="/tmp"
if [[ -z $version ]]; then
	version="2.292.0"
fi

cd $working_dir
echo "Creating the working directory"
rm -rf actions-runner
mkdir actions-runner
cd actions-runner

echo "Downloading Action Runner Packge"
curl -o actions-runner-linux-x64-${version}.tar.gz -L https://github.com/actions/runner/releases/download/v${version}/actions-runner-linux-x64-${version}.tar.gz

echo "Extracting the runner package"
tar xzf ./actions-runner-linux-x64-${version}.tar.gz

echo "Installing dependencies"
sudo ./bin/installdependencies.sh
if [[ $? -ne 0 ]]; then
	echo "Failed to install the dependencies"
        echo "Exiting..!"
        exit 1
fi

echo "Configuring the runner"
host=`hostname`
labels='maven,self-hosted,test'
./config.sh --unattended --url https://github.com/cgifed --token $token --name $host --labels $labels --replace
if [[ $? -ne 0 ]]; then
	echo "Failed to configure github runner"
	echo "Exiting....!"
	exit 1
fi

echo "Running the runner"
nohup ./run.sh &
