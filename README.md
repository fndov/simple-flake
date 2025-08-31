### This flake is designed to be setup using your current configuration.nix.

Benefits of flakes include:
- A start to code organization
- Version locking
- Full reproducibility
---
Import flow
```
┌─ flake.nix           (Start)
├─ flake.lock          (Version locking)
├─ configuration.nix   (System configuration)
└─ home.nix            (Home Manager configuration)
```
---
Setup
```
git clone https://github.com/fndov/simple-flake ~/.system && rm -rf ~/.system/.git
cp /etc/nixos/configuration.nix ~/.system/configuration.nix
cp /etc/nixos/hardware-configuration.nix ~/.system/hardware.nix
```
Take out the import section for hardware-configuration.nix at the top (the flake does this for you now)
```
nano ~/.system/configuration.nix
```
Input your name
```
nano ~/.system/home.nix
```
---
### Commands
```
sudo nixos-rebuild switch --flake ~/.system#home
```
nixos-rebuild has a few options:
* switch  : switches to the new configuration immediately
* boot    : builds the next generation but does not switch until reboot
* dry-run : only evaluates the code to see if it works
* test    : switches to the new generation but does not save it to the boot menu

```
sudo nixos-rebuild switch --flake ~/.system#home --rollback
```
Rolls back to the previous generation.

```
sudo nix-collect-garbage
```
Deletes all previous generations so you don't run out of space.

```
sudo nix flake update --flake ~/.system#home
```
Update system.

```
nix-shell -p cowsay
```
Installs software to the shell (not the system) and is discarded when the shell (terminal) is closed.

#### Important links:

[How to setup NVIDIA](https://nixos.wiki/wiki/Nvidia) <br>
Copy paste to configuration.nix and add `config` to `{ ... }:` => `{ config, ... }:`
```
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  boot.blacklistedKernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia-drm.fbdev=1"
    "nvidia"
  ];
```


[NixOS packages](https://search.nixos.org/packages)

[NixOS options](https://search.nixos.org/options)

[Home manager options](https://home-manager-options.extranix.com/)
