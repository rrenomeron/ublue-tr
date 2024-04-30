# Rich Renomeron's Experimental Builds of Fedora Silverblue and Project Bluefin

These are [Universal Blue](https://universal-blue.org)-based images built via [BlueBuild](https://bulue-build.org)'s 
tools with a bunch of my personal preferences baked in. Currently, it's a way for me to experiment with an 
atomic operating system and adapt it to my (non-work) workflows.  Or maybe to adapt my personal workflows to The Way of
the Container. In the future, it might become the standard install for my personal devices.

Features common to both images:

- Google Chrome RPM installed (albeit in a complicated manner) and set as default browser
- [Variety](https://peterlevi.com/variety/) wallpaper changer (installed as RPM for now)
- Clocks set to AM/PM view with Weekday Display
- Curated selection of Flatpak apps
- ``<CTRL><ALT>t`` opens a terminal
- Dark styles enabled by default

For the Silverblue Images (``ghcr.io/rrenomeron/ublue-tr``):

- Visual Studio Code RPM installed with Cascadia Code fonts
- Libvirt/Virt-Manager installed on host
- Dash-to-Dock enabled by default, skipping Overview on login
- Appindicators enabled by default

For the Bluefin Images (``ghcr.io/rrenomeron/bluefin-tr``):

- Default Fedora/GNOME keybindings and fonts
- Starship disabled by default (users can enable if needed)
- GNOME Terminal as default terminal
- Rootful Docker disabled.  Users can set up [rootless Docker](https://docs.docker.com/engine/security/rootless/) for themselves.

We default to Fedora 39.  If you want Fedora 40, add ``-40`` to the image name (e.g ``ublue-tr-40``).

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

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

If you want to try Fedora 40, use ``ublue-tr-40`` as the image name.  Eventually this will become the
regular image, once I determine Fedora 40 is stable enough and I've confident in the upgrade experience.

## Installing via ISO

You can generate an offline ISO with the instructions available [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso).  Or, just install Fedora Silverblue and follow the instructions above.

## Verification
> **Warning**  
> This is still boilerplate from the original template.  It might not be accurate; I haven't verified it.

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/blue-build/legacy-template
```

## TODO

- Figure out how to signal user that a Chrome update is available/freshly layered
- Figure out whether The Way will be ``(Silverblue + Bluefin stuff I like)`` or ``(Bluefin - Bluefin stuff I don't like)``
- Figure out what my development container workflow is going to look like (distrobox? toolbox? something else?)
- Automate TPM whole-disk encryption (see https://github.com/bsherman/ublue-custom/blob/main/usr/bin/luks-enable-tpm2-autounlock)


