{pkgs, ...}:
{
    # Install Programs
    environment.systemPackages = with pkgs;  [
        # browsers
        brave
        firefox

        # chill apps
        spotify #add spicetify?
        discord
        
        # work apps
        teams-for-linux
        cherrytree

        # technical
        terminator
        wireshark
        python3
        vscode
        #jetbrains.clion
        vim
        cherrytree
        gparted

        # other
        flameshot
        obs-studio
        shotcut
        gimp3
        vlc



    ];
}