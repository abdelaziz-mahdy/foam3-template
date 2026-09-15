# FOAM application template

A [FOAM3](https://github.com/foam-foundation/foam3) application as created by `./build.sh -T+setup/Project`, with foam3 as a submodule, a `Dockerfile` for containers, an `app.json` for Cloud Run and a `Dockerfile.vercel` for Vercel. Log in with `demo` / `demo`.

## Run locally

    git clone --recursive https://github.com/abdelaziz-mahdy/foam3-template
    cd foam3-template
    ./build.sh

Visit http://localhost:8080.

## Run in Docker

    docker build -t example .
    docker run --rm -p 8080:8080 -v example-journals:/opt/example/journals example

Journals, logs and documents are volumes under `/opt/example`. Set `JAVA_OPTS` to size the heap; it defaults to 75% of the container memory.

## Deploy with one click

[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run?git_repo=https://github.com/abdelaziz-mahdy/foam3-template)
[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/abdelaziz-mahdy/foam3-template&project-name=foam3-demo&repository-name=foam3-demo)

**Cloud Run** builds the `Dockerfile` and runs it on one instance (`max-instances` in `app.json`), so logins work as on a server. It needs a Google Cloud project with billing enabled. Cost for 1 vCPU and 2 GiB in us-central1: a demo visited now and then stays inside the free tier and scales to zero after idle; a request every second all month is about $71; kept warm with CPU always allocated is about $53.

**Vercel** builds `Dockerfile.vercel` and runs it as a function; a Hobby account needs no card. Vercel spreads requests over several instances that share no memory and cannot pin one, and FOAM keeps sessions in the JVM, so a login on one instance is unknown to the next. `Dockerfile.vercel` therefore sets `SESSION_DEFAULT_USER` to the admin so every visitor is signed in without a login step. Demo only. Cost: Hobby includes 4 CPU-hours, 360 GB-hours of memory and 1M invocations a month; a request every second uses the memory allowance in about a week, after which Vercel pauses the project until next month, no bill. On Pro that traffic is $20 plus about $35 of memory and up to $93 of CPU.

## Run on a VM, for example Oracle Cloud Always Free

Oracle's Always Free tier gives an Ampere A1 VM (2 OCPU, 12 GB) that stays up around the clock, enough for one container with real logins and persistent journals.

1. In the Oracle Cloud console create a VM.Standard.A1.Flex instance (Ubuntu or Oracle Linux) with a public IP, and in its subnet's security list add an ingress rule for TCP port 80.
2. SSH in and run:

       curl -fsSL https://raw.githubusercontent.com/abdelaziz-mahdy/foam3-template/main/deployment/oracle/setup.sh | bash

   It installs Docker, opens the port in the VM firewall, builds the image from this repository and starts the container with `--restart unless-stopped` and a journal volume. It prints the URL at the end.
3. To update, run the same command again; the journal volume is kept.

`REPO`, `APP` and `PORT` can be set in the environment before running the script.
