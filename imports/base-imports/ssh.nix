{...}:
{

    # enable ssh daemon
    services.openssh = {
        enable = true;
        settings = {
            # Forbid root login through SSH.
            PermitRootLogin = "yes";
            # Use keys only. Remove if you want to SSH using password (not recommended)
            PasswordAuthentication = true;
        };
        #make sure you know how to connect to github
        knownHosts = builtins.fromJSON( builtins.readFile( ../../resources/git-server-keys.json ) );

        #make sure github knows how to connect to your system
        # hostKeys = [{
        #     type = "ed25519";
        #     path = "/path/to/id";
        # }]
    };
}