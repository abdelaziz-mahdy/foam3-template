# FOAM application template

A [FOAM3](https://github.com/foam-foundation/foam3) application as created by `./build.sh -T+setup/Project`, with foam3 as a submodule, a `Dockerfile` for containers and an `app.json` for Cloud Run.

[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run?git_repo=https://github.com/abdelaziz-mahdy/foam3-template)

The button clones this repository into your Google Cloud project and deploys it to Cloud Run on one instance (`max-instances` in `app.json`), so logins work as on a server. Log in with `demo` / `demo`. Add your models under `src/` and push; Cloud Run rebuilds and redeploys. It needs a project with billing enabled; the free tier covers a demo.

## Run locally

    git clone --recursive https://github.com/abdelaziz-mahdy/foam3-template
    cd foam3-template
    ./build.sh

Visit http://localhost:8080.

## Run in Docker

    docker build -t example .
    docker run --rm -p 8080:8080 -v example-journals:/opt/example/journals example

Journals, logs and documents are volumes under `/opt/example`. Set `JAVA_OPTS` to size the heap; it defaults to 75% of the container memory.
