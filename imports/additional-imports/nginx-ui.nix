  { config, pkgs, inputs, ... }:

let
  nodeEnv = pkgs.nodejs_20;
  user = "solid";
  url = "google.com";
in {
    
    
    services.nginx.enable = true;
    services.nginx.virtualHosts."hmi-ui" = {
    # locations."hmi-ui".index = "index.html";
    locations."/".tryFiles = "$uri $uri/ /index.html";
        root = url;
        listenAddresses = ["127.0.0.1" "*" ];
        listen = [{

            addr = "0.0.0.0";
            port = 5000;

        }];
  
    };

    environment.systemPackages = with pkgs; [

    ];

}