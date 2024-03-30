# Learning Axum Web

## Configure Google Cloud Authentication

```shell
gcloud auth configure-docker us-central1-docker.pkg.dev
```

## Docker Image

### Build

```shell
docker build --platform linux/amd64 -t us-central1-docker.pkg.dev/mindful-world-403618/dev/axum-web:1.0.0 .
```

### Push

```shell
docker push us-central1-docker.pkg.dev/mindful-world-403618/dev/axum-web:1.0.0
```

### Run

```shell
docker run -d --name axum-web -p 40000:3000 axum-web:v2.0.0 
```

## Using Docker Hub

```shell
docker.io/hachikoapp/axum-web:1.0.0
```