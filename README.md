# Logseq Publish Helper

Container to locally publish a Logseq graph to a directory.

Relies on [logseq/publish-spa](https://github.com/logseq/publish-spa/) for the
actual publishing. We just wrap the whole thing in a neat little container.

## How To

```shell
$ ./do-build-container.sh
$ ./do-publish.sh \
    /path/to/logseq/graph \
    /path/to/output [light|dark]
```

## LICENSE

Where applicable, licensed under Apache-2.0.

