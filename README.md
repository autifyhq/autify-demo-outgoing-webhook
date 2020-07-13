# autify-demo-outgoing-webhook

## Prerequisites

- [ngrok](https://ngrok.com/)
- [Docker](https://www.docker.com/)

## Usage

1. Start ngrok

   ```bash
   ./ngrok http 4567

   (snip)
   Forwarding                    https://e019d1e10024.ngrok.io -> http://localhost:4567
   (snip)
   ```

1. Go to project setting on Autify
1. Click `Add` on Webhook section
1. Set `URL` to the value obtained in #1.
1. Set `Secret` _(Note: Optional)_
1. Clone the repository

   ```bash
   git clone git@github.com:autifyhq/autify-demo-outgoing-webhook.git
   cd autify-demo-outgoing-webhook
   ```

1. Build an image from a Dockerfile

   ```bash
   docker build -t outgoing-webhook-demo --build-arg RUBY_VERSION=2.6.5-alpine3.10 --build-arg BUNDLER_VERSION=2.0.2 .
   ```

1. Start a server

   ```bash
   # Without Secret
   docker run -p 4567:80 outgoing-webhook-demo

   # With Secret
   docker run -p 4567:80 -e SECRET_TOKEN=<SECRET from \#5> outgoing-webhook-demo
   ```

1. Go to project setting on Autify
1. Set `URL` to the value obtained in #1.
1. Set `Secret` to the value obtained in #5 if you added.
1. Run a scenario on Autify
1. You can get JSON after finished a test.

### Development

Submit all changes directly to the master branch.

1. Fork the repository and create your branch from master.
1. Add changes
1. Format your code with rufo `docker run -v /path/to/autify-demo-outgoing-webhook:/usr/src/app -it outgoing-webhook-demo rufo .`
1. Create a pull request.

## License

autify-demo-outgoing-webhook © [Autify Engineers](https://github.com/autifyhq). Released under the [MIT License](LICENSE).<br/>
Authored and maintained by [Autify Engineers](https://github.com/autifyhq) with help from [contributors](https://github.com/autifyhq/autify-demo-outgoing-webhook/graphs/contributors).

[github-action-badge]: https://github.com/autifyhq/autify-demo-outgoing-webhook/workflows/lint/badge.svg

[pr-welcome-badge]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg
[pr-welcome-link]: http://makeapullrequest.com

[demo-badge]: https://img.shields.io/badge/Autify-Demo-brightgreen
[demo-link]:  https://github.com/search?utf8=%E2%9C%93&q=demo%2Buser%3Aautifyhq&type=Repositories&ref=searchresults

![Check Markdown links][github-action-badge] [![PRs Welcome][pr-welcome-badge]][pr-welcome-link] [![Demo Badge][demo-badge]][demo-link]
