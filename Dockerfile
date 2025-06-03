FROM localstack/localstack

RUN apt-get update && apt-get -y --no-install-recommends install \
    vim \
    wget \
    curl