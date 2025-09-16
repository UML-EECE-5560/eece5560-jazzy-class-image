dirname=${PWD##*/}

docker build \
  --no-cache \
  -t "paulrobinette/${dirname}:v1" .