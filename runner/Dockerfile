FROM ubuntu:24.04

ARG RUNNER_VERSION="2.333.1"
ARG DEBIAN_FRONTEND=noninteractive

ARG ONE_TIME_REGISTRATION_TOKEN
ARG LABELS
ARG GITHUB_URL_REPO_NAME
ARG RUNNER_NAME

RUN test -n "$ONE_TIME_REGISTRATION_TOKEN" \
 && test -n "$GITHUB_URL_REPO_NAME" \
 && test -n "$RUNNER_NAME" \
  || (echo "Missing required build arguments" && exit 1)

# Update and upgrade the system
RUN apt update -y && apt upgrade -y

# Add a user named docker
RUN useradd -m docker

# Install necessary packages
RUN apt install -y --no-install-recommends \
    curl build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip jq
RUN apt-get -yqq install ssh
# Set up the actions runner
RUN cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Change ownership to docker user and install dependencies
RUN chown -R docker /home/docker && /home/docker/actions-runner/bin/installdependencies.sh

# Copy the start script and make it executable
COPY --chmod=+x start.sh /start.sh

# Switch to docker user
USER docker

ENV ONE_TIME_REGISTRATION_TOKEN=${ONE_TIME_REGISTRATION_TOKEN} \
    LABELS=${LABELS} \
    GITHUB_URL_REPO_NAME=${GITHUB_URL_REPO_NAME} \
    RUNNER_NAME=${RUNNER_NAME}

# Define the entrypoint
ENTRYPOINT ["/start.sh"]
