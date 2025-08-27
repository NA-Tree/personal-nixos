{...}:
{
    nixpkgs.overlays = [ # disable sun4i-drm?
    (final: super: {
        makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
    ];

    nix.settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Deduplicate and optimize nix store
        auto-optimise-store = true;
        trusted-users = [ "@wheel" ];
        allowed-users = [ "@wheel" ]; # could also be "root" (?)

    };

}