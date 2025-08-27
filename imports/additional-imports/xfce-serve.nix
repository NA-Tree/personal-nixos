{ config, pkgs, inputs, ... }:

let
  nodeEnv = pkgs.nodejs_20;
  user = "solid";
in {

  imports = [
    ../additional-imports/xfce.nix
    ../additional-imports/nginx-ui.nix
  ];

  #add code here to create a kiosk mode of the UI
    environment.systemPackages = with pkgs;  [
      firefox
    ];

}











