# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  nixpkgs,
  ...
}: {

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";

  imports = [
    ./extra-packages.nix
    ../../imports/additional-imports/xmrig.nix
  ];


}
