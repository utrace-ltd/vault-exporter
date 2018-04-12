# Vault Exporter

Export [Hashicorp Vault](https://github.com/hashicorp/vault) health to [Prometheus](https://github.com/prometheus/prometheus).

## Exported Metrics

| Metric | Meaning | Labels |
| ------ | ------- | ------ |
| vault_up | Was the last query of Vault successful, | |
| vault_initialized | Is the Vault initialised (according to this node). | |
| vault_sealed | Is the Vault node sealed. | |
| vault_standby | Is this Vault node in standby. | |
| vault_info | Various info about the Vault node. | version, cluster_name, cluster_id |

## Dashboards and alerts

<img align="right" width="192" height="200" src="dashboard.png">

Example dashboards and alerts for this exporter are included in the
mixin directory, in the form of a jsonnet monitoring mixin.  They
are designed to be combined with the [prometheus-ksonnet](https://github.com/kausalco/public/tree/master/prometheus-ksonnet) package.

To install this mixin, use [ksonnet](https://ksonnet.io/):

```sh
$ ks registry add vault_exporter https://github.com/grapeshot/vault_exporter
$ ks pkg install vault_exporter/vault-mixin
```

Then to use, in your `main.jsonnet` file:

```js
local prometheus = (import "prometheus-ksonnet/prometheus-ksonnet.libsonnet");
local vault = (import "vault-mixin/mixin.libsonnet");

prometheus + vault {
  jobs+: {
    vault: "<my vault namespace>/<my value name label>",
  },
}
```

## Flags

```bash
$ ./vault_exporter -h
usage: vault_exporter [<flags>]

Flags:
  -h, --help              Show context-sensitive help (also try --help-long and --help-man).
      --web.listen-address=":9410"  
                          Address to listen on for web interface and telemetry.
      --web.telemetry-path="/metrics"  
                          Path under which to expose metrics.
      --vault-tls-cacert=VAULT-TLS-CACERT  
                          The path to a PEM-encoded CA cert file to use to verify the Vault server SSL certificate.
      --vault-tls-client-cert=VAULT-TLS-CLIENT-CERT  
                          The path to the certificate for Vault communication.
      --vault-tls-client-key=VAULT-TLS-CLIENT-KEY  
                          The path to the private key for Vault communication.
      --insecure-ssl      Set SSL to ignore certificate validation.
      --log.level="info"  Only log messages with the given severity or above. Valid levels: [debug, info, warn, error, fatal]
      --log.format="logger:stderr"  
                          Set the log target and format. Example: "logger:syslog?appname=bob&local=7" or "logger:stdout?json=true"
      --version           Show application version.
```
