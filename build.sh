docker buildx build \
  --build-arg UID=1050 \
  --platform linux/arm64/v8 \
  --push \
  --tag docker-registry.hraban.com/snapcast-server:latest \
  --tag docker-registry.hraban.com/snapcast-server:1.1 \
  .
