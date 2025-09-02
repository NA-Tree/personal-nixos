{pkgs, ...}:
{
    # Install Programs
    environment.systemPackages = with pkgs;  [
        firefox
    ];
}