port0=37017
port1=37018
port2=37019

rs=rs0

db0=db0
db1=db1
db2=db2

host=localhost

db_name=wallet-test

rs_init=$(cat <<- END
  var config = {
    "_id": "$rs",
    "members": [
      { "_id": 0, "host": "$host:$port0" },
      { "_id": 1, "host": "$host:$port1" },
      { "_id": 2, "host": "$host:$port2" }
    ]
  };
  rs.initiate(config);
END
)

docker run -d --net=host --name $db0 mongo:4 mongod --replSet $rs --port $port0 --bind_ip_all && \
docker run -d --net=host --name $db1 mongo:4 mongod --replSet $rs --port $port1 --bind_ip_all && \
docker run -d --net=host --name $db2 mongo:4 mongod --replSet $rs --port $port2 --bind_ip_all && \
sleep 3 && \
docker ps && \
docker exec -it $db0 mongo --host $host --port $port0 --eval "$rs_init"
docker exec -it $db0 mongo --host $host --port $port0 --eval "rs.status()"

echo ""
echo "DB_URI=mongodb://$host:port0,$host:$port1,$host:$port2/$db_name?replicaSet=$rs"

# stop:
# docker ps | grep 'mongo:4' | cut -d ' ' -f1 | xargs docker container stop
