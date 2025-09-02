{ lib, ... }:

{
  imports = [ ];

  boot = {
    initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "sd_mod" "sr_mod" ];

    binfmt.emulatedSystems = [ "aarch64-linux" ];

    loader = {
        grub.enable = lib.mkDefault false;
        generic-extlinux-compatible.enable = lib.mkDefault true;
      };
  };

  # Defines the platform to use x86_64-linux architecture
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/35bb1f3f-dc76-430e-8d5a-c5c8cffd314a";
    fsType = "ext4";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s3.useDHCP = lib.mkDefault true;


  # Allow for virtualization 
  virtualisation.virtualbox.guest.enable = true;
}