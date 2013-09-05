
#Getting the bigtop repo that hosts hadoop
sudo wget -O /etc/yum.repos.d/bigtop.repo http://www.apache.org/dist/bigtop/stable/repos/centos5/bigtop.repo

#Setting the base URL
baseurl=http://archive.apache.org/dist/incubator/bigtop/bigtop-0.3.0-incubating/repos/centos5/

#Install Hadoop
sudo yum install hadoop -y

