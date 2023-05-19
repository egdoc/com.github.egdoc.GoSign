# Dike GoSign Desktop Flatpak

Unofficial flatpak for Infocert GoSign Desktop

## About
This flatpak is created from the official release of GoSign Desktop for linux, which
is only distributed as a [deb](https://rinnovofirma.infocert.it/gosign/download/linux/latest/) package.

# Build & run
To build and install the flatpak:

```bash
flatpak-builder --user --install --install-deps-from=flathub build-dir com.github.egdoc.GoSign.yml --force-clean
```

To run the application you can use the desktop launcher or run:

```bash
flatpak run com.github.egdoc.GoSign.yml
```
