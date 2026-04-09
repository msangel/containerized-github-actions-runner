# containerized-github-actions-runner
Containerized GitHub Actions runner

Creates a GitHub Actions runner. It is parameterized with the following required values:
- `RUNNER_NAME`
- `ONE_TIME_REGISTRATION_TOKEN`
- `GITHUB_URL_REPO_NAME`

Optionally, you can provide `LABELS` (more commonly known as `tags`).

**On the very first run, it registers itself.** 

On subsequent runs, it simply connects and starts working. It does not contain any self-unregister logic, so there is no risk of it disappearing on its own. It will remain registered until you remove it manually, or until GitHub automatically removes it according to its retention policy if it is not used.
