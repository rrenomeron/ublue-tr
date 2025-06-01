# Custom Bluefin and Fedora Silverblue Bootable Containers

These are [Bootable Container](https://containers.github.io/bootable/) images built from 
[Universal Blue](https://universal-blue.org) base images
with [BlueBuild](https://bulue-build.org)'s tools.
The images contain either the [Fedora Silverblue](https://silverblue.fedoraproject.org) or 
[Bluefin](https://projectbluefin.io) operating
system with with my personal preferences baked in.  The image based on Bluefin DX (``bluefin-dx-tr``) is my daily driver.

Modifications common to both images:

- Google Chrome RPM installed and set as default browser
- [Variety](https://peterlevi.com/variety/) wallpaper changer (installed as RPM for now)
- Clocks set to AM/PM view with Weekday Display
- Curated selection of Flatpak apps installed automatically at runtime (this overrides Bluefin's
  default flatpak choices)
- Single click to open items in Nautilus
- Use smaller icons in Nautilus icon view
- Sort directories first in Nautilus and GTK file choosers
- Dark styles enabled by default
- [System76 wallpaper collection](https://system76.com/merch/desktop-wallpapers)
- Historical Ubuntu wallpapers, mostly from the LTS versions
- [Intel One Mono](https://www.intel.com/content/www/us/en/company-overview/one-monospace-font.html) set as default monospace font

For the Silverblue Images (``ghcr.io/rrenomeron/ublue-tr``):

- Visual Studio Code RPM installed
- Libvirt/Virt-Manager installed on host
- Docker CE installed with rootful Docker disabled
- Dash-to-Dock enabled by default, skipping Overview on login
- Appindicators enabled by default
- Logo Menu enabled by default (like Bluefin)
- Windows have minimize and maximize buttons (like Ubuntu and Bluefin)
- ``<CTRL><ALT>t`` opens a terminal

For the Bluefin Images (``ghcr.io/rrenomeron/bluefin-dx-tr``):

- Starship disabled by default (users can enable if needed)
- Rootful Docker disabled.  Users can set up 
  [rootless Docker](https://docs.docker.com/engine/security/rootless/) for themselves.
- A different list of default flatpaks

## Which Image? Which Version?

Fedora Silverblue:

- ``ghcr.io/rrenomeron/ublue-tr:gts`` -- Fedora 41, updated weekly
- ``ghcr.io/rrenomeron/ublue-tr:latest`` -- Fedora 42, updated daily

Bluefin (see 
[Bluefin's docs](https://docs.projectbluefin.io/administration#upgrades-and-throttle-settings)
for more details):

- ``ghcr.io/rrenomeron/bluefin-dx-tr:gts`` -- [Bluefin GTS](https://docs.projectbluefin.io/administration#bluefin-gts) with developer tools ("DX image"),
  updated weekly
- ``ghcr.io/rrenomeron/bluefin-dx-tr:stable`` -- Bluefin Stable with developer tools, updated
  weekly
- ``ghcr.io/rrenomeron/bluefin-dx-tr:latest`` -- Bluefin Latest with developer tools, updated
  daily

## Installation

First, install any [Fedora Atomic](https://fedoraproject.org/atomic-desktops/) or
[Universal Blue](https://universal-blue.org) desktop edition (preferably one that features
GNOME, like Silverblue or Bluefin).

Then use ``bootc switch`` to switch to the image you want.  For example:
```
sudo bootc switch ghcr.io/rrenomeron/ublue-tr:gts --enforce-container-sigpolicy
```
Then reboot

```
systemctl reboot
```

## Installing via ISO

> **Warning**
> This has not been tested in a while, and probably does not work.

If you have ``podman`` installed on your system, you can generate an offline ISO with the
``download-iso.sh`` script in this directory, like this:
```
./download-iso.sh $IMAGE_NAME $TAG_NAME
```
where ``$IMAGE_NAME`` is one of ``ublue-tr``, ``bluefin-tr``, or ``bluefin-dx-tr`` and
``TAG_NAME`` corresponds to ``stable`` (``bluefin-dx-tr`` image only), ``gts``, or ``latest``.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s
[cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the
`cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/rrenomeron/ublue-tr:gts
cosign verify --key cosign.pub ghcr.io/rrenomeron/ublue-tr:latest
cosign verify --key cosign.pub ghcr.io/rrenomeron/bluefin-dx-tr:gts
cosign verify --key cosign.pub ghcr.io/rrenomeron/bluefin-dx-tr:stable
cosign verify --key cosign.pub ghcr.io/rrenomeron/bluefin-dx-tr:latest
```
## Building Locally

```
./build-image.sh [recipe file]
```
## TODO

- Figure out what my development container workflow is going to look like (distrobox? toolbox?
  something else?)
- Fix ISO generation issues for better 1st run experience on a new device, leverage what Bluefin
  is doing if possible
- Look at features from [Secure Blue](https://github.com/secureblue/secureblue) to incorporate
- Re-evaluate some Bluefin choices we disagree with



