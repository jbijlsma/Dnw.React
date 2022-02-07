docker build -t dnw2022/dnw-react:latest -f ./Dockerfile .
echo "$DOCKER_PASSWORD" | docker login -u $DOCKER_ID --password-stdin
docker push dnw2022/dnw-react:latest

kubectl apply -f k8s

kubectl rollout restart deployment/dnw-react-deployment