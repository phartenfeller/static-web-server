export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0
export SERVER_VERSION=2.10 
docker build -t static-rust-server .
