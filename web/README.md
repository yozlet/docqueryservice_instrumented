# Guide of instrumenting OTEL on WEB layer

WEB layer is run using [NGINX](https://nginx.org/en/) and its purpose is to provide means to be web-proxy, and abstracts the frontend and backend layer to the outside world.

## Integration Strategy

NGINX has the ability to be configured with an opentelemetry module that can be downloaded and configured with it. Detailed instructions are found in opentelemetry's website [here](https://github.com/nginxinc/nginx-otel/blob/main/README.md).

## Instrumentation Steps

1. In the [nginx.conf](nginx.conf), add the following code which will load the `ngx_otel_module.so`, and configure it to start emitting traces on two http endpoints.

```
load_module modules/ngx_otel_module.so;
```

* Note al the configurations that are prefixed with `otel_`. Those are the otel specific configurations.

These are the configuration options for enabling the module, setting the exporter protocol, and specifying otel-collector as the OTLP endpoint, and etc.

2. In the [Dockerfile](Dockerfile), notice how some extra modules (nginx-module-otel and nginx-module-njs) were installed, as well as additional *.js files that will
be used to render html page's traceparent, as well as emit otel web specific traces (otelweb.js). The otelweb.js script was developed using [web sdk for browser](https://opentelemetry.io/docs/languages/js/getting-started/browser/) documentation and [Honeycomb for frontend](https://docs.honeycomb.io/get-started/start-building/web/) documentation.

```
FROM docker.io/library/nginx:1.26.1
RUN apt-get update
RUN apt-get install -y curl gnupg2 ca-certificates lsb-release debian-archive-keyring
RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/debian `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list
RUN echo "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" | tee /etc/apt/preferences.d/99nginx
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y nginx-module-otel
RUN apt-get install -y nginx-module-njs
COPY nginx.conf /etc/nginx/nginx.conf
```



* The above script is necessary to register the nginx repo, and installing necessary nginx and nginx-module-otel to the container.
* Also, the module seems to have dependency with nginx:1.26.1

## Further readings

- [OpenTelemetry Concepts](https://opentelemetry.io/docs/concepts/) : Get yourself familiarized with various concepts of OpenTelemetry.