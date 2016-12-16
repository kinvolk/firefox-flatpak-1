#!/bin/sh

set -eux

rm -rf app
flatpak-builder --ccache --require-changes --repo=repo --subject="Nightly build of Firefox, `date`" app org.mozilla.firefox.json

flatpak build-update-repo --prune --prune-depth=20 repo

# The following commands should be performed once
flatpak --user remote-add --no-gpg-verify nightly-firefox ./repo || true
flatpak --user -v install nightly-firefox org.mozilla.firefox || true

flatpak update --user org.mozilla.firefox
