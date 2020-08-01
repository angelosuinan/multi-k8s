docker build -t angelosuinan/multi-client:latest -t angelosuinan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t angelosuinan/multi-server:latest -t angelosuinan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t angelosuinan/multi-worker:latest -t angelosuinan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push angelosuinan/multi-client:latest
docker push angelosuinan/multi-server:latest
docker push angelosuinan/multi-worker:latest

docker push angelosuinan/multi-client:$SHA
docker push angelosuinan/multi-server:$SHA
docker push angelosuinan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:latest
kubectl set image deployments/client-deployment client=stephengrider/multi-client:latest
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:latest