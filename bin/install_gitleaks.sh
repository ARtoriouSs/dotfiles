#!/bin/bash
set -o pipefail # a pipeline fails when any command in it fails, not only the last one

# installs gitleaks, the secret scanner for the pre-commit hook in .githooks,
# from the GitHub release with a checksum check (apt has an old 8.16 without `gitleaks git`)

version=8.30.1
archive="gitleaks_${version}_linux_x64.tar.gz"
release="https://github.com/gitleaks/gitleaks/releases/download/v${version}"

tmp_dir=$(mktemp -d) || exit 1
trap 'rm -rf "$tmp_dir"' EXIT
cd "$tmp_dir" || exit 1

curl -fsSL "$release/$archive" -o "$archive" &&
  curl -fsSL "$release/gitleaks_${version}_checksums.txt" | grep " ${archive}$" > checksums.txt &&
  sha256sum --check checksums.txt &&
  tar -xzf "$archive" gitleaks &&
  sudo install -m 755 gitleaks /usr/local/bin/gitleaks &&
  gitleaks version
