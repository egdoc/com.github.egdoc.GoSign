#!/bin/bash
#
# Author: Egidio Docile
#
# This script is basically a wrapper: it copies the udev rules
# required to use the business key, builds and installs the
# flatpak image at the user level.
#

set -o pipefail
set -o nounset
set -o errexit


readonly UDEV_RULES_DIR="/etc/udev/rules.d/"
readonly UDEV_RULE="99-com.github.egdoc.gosign-hidkey.rules"
readonly FLATHUB_REF="https://flathub.org/repo/flathub.flatpakrepo"

REPOSITORY="$(dirname "$(realpath ${0})")";
readonly REPOSITORY

UNINSTALL=0


show_help() {
cat << EOF

Install udev rules and builds GoSign desktop flatpak

Usage:
  build.sh [-h] [-u]

Options:
  -h   Show this message
  -u   Uninstall flatpak and installed udev rules
EOF
}


while getopts "hur" OPT; do
  case "${OPT}" in
    h)
      show_help
      exit 0
      ;;
    u)
      UNINSTALL=1
      ;;
    ?)
      show_help
      exit 1
  esac
done

shift $((OPTIND-1))

readonly UNINSTALL


if [ "${UNINSTALL}" -eq 1 ]; then
  echo "Removing udev rules..." >&2
  if [ -f "${UDEV_RULES_DIR}/${UDEV_RULE}" ]; then
    sudo rm "${UDEV_RULES_DIR}/${UDEV_RULE}"
    sudo udevadm control --reload
  fi

  if flatpak --user info com.github.egdoc.GoSign &> /dev/null; then
    echo "Removing flatpak runtimes..." >&2
    flatpak --user --assumeyes uninstall com.github.egdoc.GoSign
  fi

  exit 0
fi


# Check flatpak-builder is installed
if ! command -v flatpak-builder &> /dev/null; then
  echo "flatpak-builder not found, aborting..." >&2
  exit 1
fi

echo "Ensure flathub remote exists..." >&2
flatpak remote-add --user --if-not-exists flathub "${FLATHUB_REF}"

echo  "Building flatpak..." >&2
flatpak-builder \
  --user \
  --install \
  --install-deps-from=flathub build-dir "${REPOSITORY}/com.github.egdoc.GoSign.yml" \
  --force-clean

echo "Copying udev rules..." >&2
sudo cp "${REPOSITORY}/${UDEV_RULE}" "${UDEV_RULES_DIR}"
sudo udevadm control --reload

cat << EOF

Done!
Now, if you can't see the GoSign desktop launcher
in the applications menu, just logout and log back in.
Alternatively, you can launch GoSing by running:

$ flatpak run com.github.egdoc.GoSign

EOF
