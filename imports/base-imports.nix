{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    nixpkgs,
    ...
}: {
    # imports = [    
    #   # may be useful to make this elastic
    #   ./base-imports/nix.nix
    #   ./base-imports/system.nix
    #   ./base-imports/networking.nix
    #   ./base-imports/users.nix
    #   ./base-imports/ssh.nix
    #   ./base-imports/security.nix
    #   ./base-imports/packages.nix
    #   ./base-imports/auto-updater.nix
    #   ./base-imports/signal-server.nix
    #   ./base-imports/osk.nix
    # ];

    imports = lib.filesystem.listFilesRecursive ./base-imports;
}