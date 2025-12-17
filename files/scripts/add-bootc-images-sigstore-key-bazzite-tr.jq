. 
| .transports.docker."ghcr.io/rrenomeron/bazzite-tr".[0].keyPaths[0] =
        .transports.docker."ghcr.io/rrenomeron/bazzite-tr".[0].keyPath 
| del(.transports.docker."ghcr.io/rrenomeron/bazzite-tr".[0].keyPath)
| .transports.docker."ghcr.io/rrenomeron/bazzite-tr".[0].keyPaths[1] =
    "/etc/pki/containers/rrenomeron-bootc-images-repo.pub"