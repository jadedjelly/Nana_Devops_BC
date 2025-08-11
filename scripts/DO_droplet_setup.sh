!/bin/sh
sudo apt update
sudo apt upgrade -y
sudo apt install openjdk-17-jre-headless htop nodejs docker net-tools -y
adduser jkelly
usermod -aG sudo jkelly

cd /opt
# add variable for version number to be dynamic
wget https://download.sonatype.com/nexus/3/nexus-3.82.0-08-linux-x86_64.tar.gz
tar -zxvf nexus-3.82.0-08-linux-x86_64.tar.gz
adduser nexus
chown -R nexus:nexus nexus-3.82.0-08
chown -R nexus:nexus sonatype-work
echo "run_as_user="nexus"" > nexus-3.82.0-08/bin/nexus.rc
su - nexus
/opt/nexus-3.82.0-08/bin/nexus start
ps aux | grep nexus
netstat -lnpt
snap install docker
docker volume create --name nexus-data
docker run -d -p 8088:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
docker run -p 8080:8080 -p 50000:50000 -d  -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker jenkins/jenkins:latest