docker build -t cresphontes/multi-client:latest -t cresphontes/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cresphontes/multi-server:latest -t cresphontes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cresphontes/multi-worker:latest -t cresphontes/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cresphontes/multi-client:latest
docker push cresphontes/multi-server:latest
docker push cresphontes/multi-worker:latest

docker push cresphontes/multi-client:$SHA
docker push cresphontes/multi-server:$SHA
docker push cresphontes/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=cresphontes/multi-server:$SHA
kubectl set image deployments/client-deployment client=cresphontes/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cresphontes/multi-worker:$SHA