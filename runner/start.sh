#!/bin/bash

cd /home/docker/actions-runner || exit

# "unattended" = no interactive prompts
# "replace" = if existed with the same name
if [ ! -f .runner ]; then
      echo "First time setup, configuring the runner..."
      args=(
        --unattended
        --replace
        --url "https://github.com/${GITHUB_URL_REPO_NAME}"
        --token "${ONE_TIME_REGISTRATION_TOKEN}"
        --name "${RUNNER_NAME}"
        --work "_work"
      )

      if [ -n "${LABELS:-}" ]; then
        args+=(--labels "${LABELS}")
      fi

      echo "running: ./config.sh ${args[*]}"

      ./config.sh "${args[@]}"
fi

echo "Runner is configured, starting the runner service..."
exec ./run.sh
