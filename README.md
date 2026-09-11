# FOAM application template

A [FOAM3](https://github.com/foam-foundation/foam3) application as created by `./build.sh -T+setup/Project`, with foam3 as a submodule and a `Dockerfile` for containers and `Dockerfile.vercel` for Vercel.

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/abdelaziz-mahdy/foam3-template&project-name=foam3-demo&repository-name=foam3-demo)

The button clones this repository into your GitHub account and deploys it. Log in with `demo` / `demo`. Add your models under `src/` and push; Vercel rebuilds and redeploys.

## Run locally

    git clone --recursive https://github.com/abdelaziz-mahdy/foam3-template
    cd foam3-template
    ./build.sh

Visit http://localhost:8080.

## Run in Docker

    docker build -t example .
    docker run --rm -p 8080:8080 -v example-journals:/opt/example/journals example

Journals, logs and documents are volumes under `/opt/example`. Set `JAVA_OPTS` to size the heap; it defaults to 75% of the container memory.

## On Vercel

The function has 2 GB and only `/tmp` is writable, so the app starts from the seed journals on every cold start and data entered in the demo does not persist. Vercel scales the function to zero after 5 minutes without traffic.
