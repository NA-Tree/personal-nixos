{ inputs, outputs, lib, config, pkgs, nixpkgs, ... }:
{
    imports = [
        ./users.nix
    ];

    #add additional packages needed for the server
    environment.systemPackages = with pkgs; [
    
    ];
}