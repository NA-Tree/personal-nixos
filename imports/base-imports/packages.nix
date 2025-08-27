{pkgs, ...}:
{
    # Install Programs
    environment.systemPackages = with pkgs; [
        bash
        git
        openssh
        nmap
        # clamav      #antivirus
    ];
}