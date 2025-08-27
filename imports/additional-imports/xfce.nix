{ config, pkgs, inputs, ... }:

let
  user = "solid";
in {

    services = {
        xserver = {
            enable = true;
            displayManager.lightdm.enable = true;
            desktopManager.xfce.enable = true;
        };
        displayManager = {
            defaultSession = "xfce";
            autoLogin = {
                enable = true;
                user = user;
            };
        };
    };

}
