  { config, pkgs, inputs, ... }:

let
  nodeEnv = pkgs.nodejs_20;
  user = "solid";
in {
    
    
    services.nginx.enable = true;
    services.nginx.virtualHosts."hmi-ui" = {
    # locations."hmi-ui".index = "index.html";
    locations."/".tryFiles = "$uri $uri/ /index.html";
        root = "${inputs.hmi_ui_dream.packages."x86_64-linux".default}/lib/node_modules//hmi-ui/dist";
        listenAddresses = ["127.0.0.1" "*" ];
        listen = [{

            addr = "0.0.0.0";
            port = 5000;

        }];
  
    };

    environment.systemPackages = with pkgs; [
      hmi_ui_dream
    ];

}