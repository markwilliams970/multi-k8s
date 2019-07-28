docker build -t markwilliams970/multi-client:latest -t markwilliams970/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t markwilliams970/multi-server:latest -t markwilliams970/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t markwilliams970/multi-worker:latest -t markwilliams970/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push markwilliams970/multi-client:latest
docker push markwilliams970/multi-server:latest
docker push markwilliams970/multi-worker:latest

docker push markwilliams970/multi-client:$SHA
docker push markwilliams970/multi-server:$SHA
docker push markwilliams970/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment  client=markwilliams970/multi-client:$SHA
kubectl set image deployments/server-deployment  server=markwilliams970/multi-server:$SHA
kubectl set image deployments/worker-deployment  worker=markwilliams970/multi-worker:$SHA