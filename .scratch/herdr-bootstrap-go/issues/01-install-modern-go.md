Status: resolved

herdr/bootstrap.sh failed building herdr-plus: system Go 1.19 can't parse go.mod `go 1.26.2`.
Bootstrap now installs the latest official Go to ~/.local/go when Go is missing or < 1.21 (1.21+ auto-fetches the pinned toolchain).
