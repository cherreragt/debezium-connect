# Steps for use debezium + kafka to replicate data from oracle to mysql

## Requirements
- Docker Compose
- Oracle DB

## Step1
Log into the server and run the following commands as root:
```
cd /u01/app/oracle/oradata
mkdir -p recovery_area
sudo chown -R oracle:oinstall /u01/app/oracle/oradata/recovery_area
sudo chmod -R 750 /u01/app/oracle/oradata/recovery_area
```

If everything was okay the following command is not gonna return an error.
```
ls /u01/app/oracle/oradata/recovery_area
```

## Step 2

As a oracle user you have to run the following script

```
sh 01_logminer-setup.sh
```

If the script was okay in the terminal you have not to see an error

## Step 3
Next of running the script "01_logminer-setup" you have to run the following command:
```
sqlplus debezium/dbz@//localhost:1521/pdb1.example.com @inventory.sql
```

## Step 4
The following steps you shall do is install the docker images into the file "proyecto2.yaml", so run the following command

```
docker-compose -f proyecto2.yaml up -d
```

# Step 5

If the step 4 was okay you have to enter into the container terminal of debezium, so run the following commands:


```
docker exec -it debezium-connect /bin/bash

cd /libs

curl -O https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/10.7.3/kafka-connect-jdbc-10.7.3.jar

curl -O https://maven.xwiki.org/externals/com/oracle/jdbc/ojdbc8/12.2.0.1/ojdbc8-12.2.0.1.jar -o ojdbc8-12.2.0.1.jar

curl -O https://repo1.maven.org/maven2/io/debezium/debezium-connector-jdbc/2.7.0.Final/debezium-connector-jdbc-2.7.0.Final-plugin.tar.gz

curl -O https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar

mv debezium-connector-jdbc connect/

tar -xvzf debezium-connector-jdbc-2.7.0.Final-plugin.tar.gz

mv debezium-connector-jdbc connect/debezium-connector-oracle/

tar -xvzf debezium-connector-jdbc-2.7.0.Final-plugin.tar.gz

exit

```

## Step 6
You have to re start the debezium container
```
docker restart debezium-connect
```

## Step 7

Make your request to "localhost:8083/connectors/" to create the connector and configs por replicating the data of oracle db to mysql

So I exported an example postman collection with some examples and scripts, watch it