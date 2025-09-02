{pkgs, ...}:
{
    # Install Programs
    environment.systemPackages = with pkgs; [
        vim
        nano
        bash
        git
        openssh
        nmap
        # clamav      #antivirus
    ];
}