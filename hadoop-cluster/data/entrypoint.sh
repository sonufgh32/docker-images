#/bin/bash

sudo service ssh start

export HADOOP_HOME=/usr/local/hadoop
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
source ~/.bashrc

echo "JAVA_HOME="$JAVA_HOME >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

cp /data/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
cp /data/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
cp /data/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
cp /data/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml

if [ $NODE_TYPE == "master" ]; then
    ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

    sshpass -p "hadoop" ssh-copy-id -o StrictHostKeyChecking=no hadoopuser@worker1
    sshpass -p "hadoop" ssh-copy-id -o StrictHostKeyChecking=no hadoopuser@worker2

    echo "worker1" >> $HADOOP_HOME/etc/hadoop/workers
    echo "worker2" >> $HADOOP_HOME/etc/hadoop/workers

    yes | hdfs namenode -format
    start-all.sh
fi
tail -f /dev/null
