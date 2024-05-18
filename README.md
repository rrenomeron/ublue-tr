# Rich Renomeron's Builds of Fedora Silverblue and Project Bluefin

These are [Universal Blue](https://universal-blue.org)-based images built via
[BlueBuild](https://bulue-build.org)'s tools with a bunch of my personal preferences baked in.
The images contain either the [Fedora Silverblue](https://silverblue.fedoraproject.org) or 
[Project Bluefin](https://projectbluefin.io) operating
system with custom modifications.  I am currently daily driving the Bluefin image.

Features common to both images:

- Google Chrome RPM installed and set as default browser
- [Variety](https://peterlevi.com/variety/) wallpaper changer (installed as RPM for now)
- Clocks set to AM/PM view with Weekday Display
- Curated selection of Flatpak apps installed automatically at runtime
- ``<CTRL><ALT>t`` opens a terminal
- Single click to open items in Nautilus
- Use smaller icons in Nautilus icon view
- Sort directories first in Nautilus and GTK file choosers
- Dark styles enabled by default
- [System76 wallpaper collection](https://system76.com/merch/desktop-wallpapers)
- Historical Ubuntu wallpapers, mostly from the LTS versions

For the Silverblue Images (``ghcr.io/rrenomeron/ublue-tr``):

- Visual Studio Code RPM installed with Cascadia Code fonts
- Libvirt/Virt-Manager installed on host
- Dash-to-Dock enabled by default, skipping Overview on login
- Appindicators enabled by default
- Logo Menu enabled by default (like Bluefin)

For the Bluefin Images (``ghcr.io/rrenomeron/bluefin-tr-dx`` or ``ghcr.io/rrenomero/bluefin-tr``):

- Developer mode enabled by default on the ``-dx`` image.  Switching between ``dx`` and non-``dx``
  images via ``ujust`` not (yet) supported.
- Default Fedora/GNOME keybindings, icons and fonts
- Starship disabled by default (users can enable if needed)
- GNOME Terminal as default terminal
- Rootful Docker disabled.  Users can set up 
  [rootless Docker](https://docs.docker.com/engine/security/rootless/) for themselves.

We default to Fedora 39.  If you want Fedora 40, add ``-canary`` to the image name 
(e.g ``ublue-tr-canary``).

## Installation

> **Warning**  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/rrenomeron/ublue-tr:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/rrenomeron/ublue-tr:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

- If you are on an existing Universal Blue-based atomic installation, you should just be able to
  rebase directly:
  ```
  sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/rrenomeron/ublue-tr:latest
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build.  

If you want to try Fedora 40, use ``ublue-tr-canary`` as the image name.  Eventually this will
become the regular image, once I determine Fedora 40 is stable enough and I'm confident in the
upgrade experience.

## Installing via ISO

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

## TODO

- Figure out whether The Way will be ``(Silverblue + Bluefin stuff I like)`` or ``(Bluefin -
  Bluefin stuff I don't like)``
- Figure out what my development container workflow is going to look like (distrobox? toolbox?
  something else?)



