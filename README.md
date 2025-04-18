# Rich Renomeron's Builds of Fedora Silverblue and Project Bluefin

These are [Universal Blue](https://universal-blue.org)-based images built via
[BlueBuild](https://bulue-build.org)'s tools with a bunch of my personal preferences baked in.
The images contain either the [Fedora Silverblue](https://silverblue.fedoraproject.org) or 
[Project Bluefin](https://projectbluefin.io) operating
system with custom modifications.  I am currently daily driving the Bluefin DX image.

Features common to both images:

- Google Chrome RPM installed and set as default browser
- [Variety](https://peterlevi.com/variety/) wallpaper changer (installed as RPM for now)
- Clocks set to AM/PM view with Weekday Display
- Curated selection of Flatpak apps installed automatically at runtime
- ``<CTRL><ALT>t`` opens a terminal, which is Gnome Terminal instead of Ptyxis
- Single click to open items in Nautilus
- Use smaller icons in Nautilus icon view
- Sort directories first in Nautilus and GTK file choosers
- Dark styles enabled by default
- [System76 wallpaper collection](https://system76.com/merch/desktop-wallpapers)
- Historical Ubuntu wallpapers, mostly from the LTS versions

For the Silverblue Images (``ghcr.io/rrenomeron/ublue-tr``):

- Visual Studio Code RPM installed
- Libvirt/Virt-Manager installed on host
- Docker CE installed with rootful Docker disabled
- Dash-to-Dock enabled by default, skipping Overview on login
- Appindicators enabled by default
- Logo Menu enabled by default (like Bluefin)
- Cascadia Code set as default monospace font
- Windows have minimize and maximize buttons (like Ubuntu and Bluefin)
- Use the ``gts`` tag for Fedora 41 and ``latest`` for Fedora 42

For the Bluefin Images (``ghcr.io/rrenomeron/bluefin-tr-dx`` or ``ghcr.io/rrenomero/bluefin-tr``):

- Developer mode enabled by default on the ``-dx`` image.  Switching between ``dx`` and non-``dx``
  images via ``ujust`` not (yet) supported.
- Default Fedora/GNOME keybindings, icons and fonts
- Starship disabled by default (users can enable if needed)
- GNOME Terminal as default terminal
- Rootful Docker disabled.  Users can set up 
  [rootless Docker](https://docs.docker.com/engine/security/rootless/) for themselves.


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
./download-iso.sh $IMAGE_NAME
```
where ``$IMAGE_NAME`` is one of ``ublue-tr``, ``ublue-tr-canary``, ``bluefin-tr``,
``bluefin-dx-tr-``, or ``bluefin-dx-tr-canary``.

## Verification
> **Warning**  
> This is still boilerplate from the original template.  It might not be accurate; I haven't
> verified it.

These images are signed with [Sigstore](https://www.sigstore.dev/)'s
[cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the
`cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/blue-build/legacy-template
```
## Building Locally

```
bluebuild build --build-driver=podman [recipe file]
```
## TODO

- Figure out what my development container workflow is going to look like (distrobox? toolbox?
  something else?)
- Fix ISO generation issues for better 1st run experience on a new device
- Look at features from [Secure Blue](https://github.com/secureblue/secureblue) to incorporate
- Re-evaluate some Bluefin choices we disagree with (e.g. Mission Center over GNOME
  System Monitor)



