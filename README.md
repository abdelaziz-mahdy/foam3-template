# FOAM application template

A [FOAM3](https://github.com/foam-foundation/foam3) application as created by `./build.sh -T+setup/Project`, with foam3 as a submodule and a `Dockerfile` for containers and `Dockerfile.vercel` for Vercel.

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/abdelaziz-mahdy/foam3-template&project-name=foam3-demo&repository-name=foam3-demo)
[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run?git_repo=https://github.com/abdelaziz-mahdy/foam3-template)

Either button clones this repository into your account and deploys it. Add your models under `src/` and push; the host rebuilds and redeploys.

**Vercel is a demo, not a deployment.** Vercel runs the container as a function: requests are spread over several instances that share no memory, there is no instance cap or session affinity, and only `/tmp` is writable. FOAM keeps sessions in the JVM, so a login on one instance is unknown to the next and a real login loops. `Dockerfile.vercel` therefore sets `SESSION_DEFAULT_USER` to the admin (`demo` / `demo`), and `deployment/vercel/run.sh` passes it as `-Dsession.defaultUser`, so every new session on every instance is signed in as the admin. Unset the variable in the Vercel project settings to get the login page back, and do not deploy anything real this way.

**Cloud Run keeps one instance.** `app.json` sets `max-instances` to 1 and builds the plain `Dockerfile`, so sessions and logins behave as on a server. It needs a Google Cloud project with billing enabled; the free tier covers a demo.

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
