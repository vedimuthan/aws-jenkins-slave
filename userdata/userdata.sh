#!/bin/sh -x
sudo yum -y update
sudo yum -y install java-1.8.0-openjdk.x86_64
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install ${jen} -y
#sudo service jenkins start

sleep 60
#!/bin/bash

set -xe

NODE_NAME=`hostname -f`

# Download CLI jar from the master
curl ${MASTER_URL}/jnlpJars/jenkins-cli.jar -o ~/jenkins-cli.jar
curl ${MASTER_URL}/jnlpJars/agent.jar -o ~/agent.jar

# Create node according to parameters passed in
cat <<EOF | java -jar ~/jenkins-cli.jar -auth "${MASTER_USERNAME}:${MASTER_PASSWORD}" -s "${MASTER_URL}" create-node "$NODE_NAME" |true
<slave>
  <name>$NODE_NAME</name>
  <description></description>
  <remoteFS>/var/lib/jenkins</remoteFS>
  <numExecutors>${NUM_EXECUTORS}</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
  <launcher class="hudson.slaves.JNLPLauncher">
    <workDirSettings>
      <disabled>false</disabled>
      <internalDir>remoting</internalDir>
      <failIfWorkDirIsMissing>false</failIfWorkDirIsMissing>
    </workDirSettings>
  </launcher>
  <label>${LABELS}</label>
  <nodeProperties/>
  <userId>${USER}</userId>
</slave>
EOF
# Creating the node will fail if it already exists, so |true to suppress the
# error. This probably should check if the node exists first but it should be
# possible to see any startup errors if the node doesn't attach as expected.


# Run jnlp launcher
java -jar ~/agent.jar -jnlpUrl ${MASTER_URL}/computer/$NODE_NAME/slave-agent.jnlp -jnlpCredentials "${MASTER_USERNAME}:${MASTER_PASSWORD}" -workDir "/var/lib/jenkins"
