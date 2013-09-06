#!/usr/bin/sh

#Create username hadoop and configure Passwordless login
#Create username
sudo /usr/sbin/useradd hadoop
echo "Please enter password for hadoop user when prompted"
sudo passwd hadoop

sh createusername.sh

#Downloading and extracting the hadoop source
sudo mkdir /opt/hadoop
cd /opt/hadoop/
sudo wget http://apache.mesi.com.ar/hadoop/common/hadoop-1.2.0/hadoop-1.2.0.tar.gz
hadoop_build=`ls /opt/hadoop/*.tar.gz`
sudo chown hadoop $hadoop_build
sudo tar -xzf $hadoop_build
hadoop_dir=`ls /opt/hadoop/ | grep -v tar`
sudo mv $hadoop_dir hadoop
sudo chown -R hadoop /opt/hadoop
cd /opt/hadoop/hadoop/
#Configuring hadoop
sudo su - root --session-command="find /opt/hadoop/hadoop/conf -name core-site.xml | xargs sed -i '/<configuration/a\<property>\
    <name>fs.default.name</name>\
    <value>hdfs://localhost:9000/</value>\
</property>\
<property>\
    <name>dfs.permissions</name>\
    <value>false</value>\
</property>'"

sudo su - root --session-command="find /opt/hadoop/hadoop/conf -name hdfs-site.xml | xargs sed -i '/<configuration/a\<property>\
	<name>dfs.data.dir</name>\
	<value>/opt/hadoop/hadoop/dfs/name/data</value>\
	<final>true</final>\
</property>\
<property>\
	<name>dfs.name.dir</name>\
	<value>/opt/hadoop/hadoop/dfs/name</value>\
	<final>true</final>\
</property>\
<property>\
	<name>dfs.replication</name>\
	<value>2</value>\
</property>'"

sudo su - root --session-command="find /opt/hadoop/hadoop/conf -name mapred-site.xml | xargs sed -i '/<configuration/a\<property>\
        <name>mapred.job.tracker</name>\
	<value>localhost:9001</value>\
</property>'"

#sudo su - root --session-command="echo \"export JAVA_HOME=$JAVA_HOME ; export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true"\" >> /opt/hadoop/hadoop/conf/hadoop-env.sh

sudo su - root --session-command="find /opt/hadoop/hadoop/conf -name hadoop-env.sh | xargs sed -i '/export/a\export JAVA_HOME=$JAVA_HOME ; export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true'"

sudo chown -R hadoop /opt/hadoop/hadoop/
#Format Name Node
#sudo su - hadoop
#cd /opt/hadoop/hadoop
sudo su - hadoop --session-command="/opt/hadoop/hadoop/bin/hadoop namenode -format"

#Start hadoop services
sudo su - hadoop --session-command="/opt/hadoop/hadoop/bin/start-all.sh"

#Test and access hadoop services
$JAVA_HOME/bin/jps

hadoop_proc=`ps ax | grep hadoop | wc -l`
if [ $hadoop_proc -ge 2 ]
then
	echo "Installation successful"
else
	echo "Installation failed"
fi
 
