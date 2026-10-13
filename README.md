# Overview

metis-replica-node, adjusted to work with central-proxy-docker

`cp default.env .env`, adjust the `DATA_TRANSPORT_LAYER__L1_RPC_ENDPOINT` and
`DATA_TRANSPORT_LAYER__L1_BEACON_ENDPOINT`to your own Ethereum node. If you need or want the finality tag to be
up-to-date in l2geth RPC, set `DATA_TRANSPORT_LAYER__SYNC_L1_BATCH=true`.

For faster sync, set a `DTL_SNAPSHOT` and `SNAPSHOT`. Note l2geth won't sync until l1dtl is up-to-date.

To start, `./metisd up`. To update, `./metisd update` followed by `./metisd up`.

The Ethereum node need not be an archive, but should have full eth_getLogs and tx indexing. For Geth
`--history.transactions=0` and for Nethermind `--Receipt.TxLookupLimit=0`.

If you are syncing l1dtl from scratch or an old snapshot, you may need an archive RPC during sync only, so that
`eth_getBlockByNumber` succeeds.

## Metrics

Both l2geth and l1dtl carry the `metrics.*` labels that the Prometheus in [central-proxy-docker](https://github.com/CryptoManufaktur-io/central-proxy-docker)
discovers. Use `:ext-network.yml` in `COMPOSE_FILE` so Prometheus can reach the containers. The ports are
container-internal and not published.

| Service | Port | Path |
|---------|------|------|
| l2geth | `METRICS_PORT` (6060) | `/debug/metrics/prometheus` (geth `--metrics --pprof`) |
| l1dtl | 7878 | `/metrics` |

To disable l2geth metrics, override its `command` in `custom.yml` without `--metrics`/`--pprof*`.

`custom.yml` is not tracked by git and can be used to override anything in the provided `metis.yml`

This is Metis Docker v1.2.0
