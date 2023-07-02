# Dike GoSign Desktop Flatpak

Unofficial flatpak for Infocert GoSign Desktop

## About
This flatpak is created from the official release of GoSign Desktop for linux, which
is only distributed as a [deb](https://rinnovofirma.infocert.it/gosign/download/linux/latest/) package.

# Build & run
Clone this repository:

```bash
git clone --resursive https://github.com/egdoc/com.github.egdoc.GoSign
```

As a prerequisite to build this flathub image you must install `flatpak-builder`.
To build and install the flatpak you can use the build.sh wrapper
which also installs the udev rules required for the application to
see the business key:

```bash
./build.sh
```
 To uninstall the flatpak and remove the udev keys:

 ```bash
 ./build.sh -u
 ```

If you can't see the GoSign desktop launcher
in the applications menu, just logout and log back in.
Alternatively, you can launch GoSing by running:

```bash
flatpak run com.github.egdoc.GoSign.yml
```
