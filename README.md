# Rich Renomeron's Experimental Build of Fedora Silverblue

This is a [Universal Blue](https://universal-blue.org)-based image built via [BlueBuild](https://bulue-build.org)'s 
tools with a bunch of my personal preferences baked in. Currently, it's a way for me to experiment with an 
atomic operating system and adapt it to my (non-work) workflows.  Or maybe to adapt my personal workflows to The Way of
the Container. In the future, it might become the standard install for my personal devices.

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

- Find a way, any way, to get the Google Chrome RPM installed instead of relying on the Flatpak.  (The usual way
  of putting the Chrome RPM onto an atomic OS doesn't currently work because of [a bug in RPM](https://github.com/rpm-software-management/rpm/issues/2577)).  The current best guess is to run it out of toolbox, but need a way to make sure that particular container is available for all users, complete with a "just works" ``.desktop`` file and default browser integration.
- Figure out what my development container workflow is going to look like (distrobox? toolbox? something else?)
- Borrow carefully curated features from [Bluefin](https://github.com/ublue-os/bluefin)

