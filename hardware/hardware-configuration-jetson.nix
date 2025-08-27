{ lib, hardware, inputs, outputs, jetpack-nixos, config, ... }:
{
  imports = [
    # inputs.jetpack-nixos.legacyPackages.aarch64-linux
    # inputs.jetpack-nixos.legacyPackages.x86_64-linux
  ];




  boot = {
    
    initrd.availableKernelModules = [
      "usbhid"
      "usb_storage"
      "vc4"
      "pcie_brcmstb"              # required for the pcie bus to work
      "reset-raspberrypi"         # required for vl805 firmware to load
    ];

    loader = {
      grub.enable = lib.mkDefault false;
      generic-extlinux-compatible.enable = lib.mkDefault true;
    };

  };

  fileSystems."/" =
  { 
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
  };

  hardware.enableRedistributableFirmware = true;

  hardware.nvidia-jetpack.enable = true;
  hardware.nvidia-jetpack.som = "orin-nano"; # Other options include xavier-agx, xavier-nx, orin-agx, and xavier-nx-emmc
  hardware.nvidia-jetpack.carrierBoard = "devkit";

  # Enable GPU support - needed even for CUDA and containers
  hardware.graphics.enable = true;
}