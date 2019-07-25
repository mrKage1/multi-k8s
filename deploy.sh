#!/bin/bash
DOCKER_USERNAME="$1"
for i in client server worker; do
docker build -t "$DOCKER_USERNAME/multi-$i:latest" -t "$DOCKER_USERNAME/multi-$i:$SHA" -f "./$i/Dockerfile" "./$i"
docker push "$DOCKER_USERNAME/multi-$i:latest"
docker push "$DOCKER_USERNAME/multi-$i:$SHA"
done

#docker build -t "$DOCKER_USERNAME/multi-client:latest" -t "$DOCKER_USERNAME/multi-client:$SHA" -f ./client/Dockerfile ./client
#docker build -t "$DOCKER_USERNAME/multi-server" -f ./server/Dockerfile ./server
#docker build -t "$DOCKER_USERNAME/multi-worker" -f ./worker/Dockerfile ./worker

#docker push "$DOCKER_USERNAME/multi-client:latest"
#docker push "$DOCKER_USERNAME/multi-client:$SHA"
#..
#..
#..
#..

kubectl apply -f k8s

#kubectl set image deployments/server-deployment server="$DOCKER_USERNAME/multi-server:$SHA"

for i in client server worker; do
kubectl set image "deployments/$i-deployment" "$i"="$DOCKER_USERNAME/multi-$i:$SHA"
done

