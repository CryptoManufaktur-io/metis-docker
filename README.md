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

`custom.yml` is not tracked by git and can be used to override anything in the provided `metis.yml`

This is Metis Docker v1.2.0
