{ ... }:
{  

  users.users.root = {
    initialPassword = "SOLIDROOT";
    openssh.authorizedKeys.keys = [  ];
  };

  users.users.oren = {
    isNormalUser  = true;
    home  = "/home/solid";
    password = "Oren@123+";
    description  = "Solid System Admin user";
    extraGroups  = [ "wheel" "networkmanager" "vboxsf" ];
    openssh.authorizedKeys.keys  = [  ];
  };
}
