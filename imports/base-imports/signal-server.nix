{ config, pkgs, inputs, vars, ... }:
let
  user = vars.user;
in {

  services.postgresql = {
    
    enable = true;
    
    ensureDatabases = [ "${user}" ];
    ensureUsers = [{ 
      name = "${user}";
      ensureDBOwnership = true;      
    }];

    settings = {
      port = 5434;
      # ssl = true; #we will likely want to enable ssl but this was causing a problem ( needs a .crt and .key file )
    };


    # authentication = pkgs.lib.mkOverride 10 ''
    authentication = pkgs.lib.mkForce ''
     
      #type database  DBuser  auth-method
      local all       all     trust
      host  sameuser  all     0.0.0.0/0    trust
    '';

    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE ${user} WITH LOGIN PASSWORD '${user}' CREATEDB;
      GRANT ALL PRIVILEGES ON DATABASE ${user} TO ${user};
    '';
  };

  environment.systemPackages = with pkgs; [
    openssl
  ];

  systemd.services."signal-server" = {
    
    path = [ "run/current-system/sw" ];

    environment = {
        AUTH_SECRET="random string";
        DATABASE_URL="postgres://${user}:${user}@localhost:5434/${user}?socket=/tmp/postgresql/.s.PGSQL.5434";
        PORT="7772";
        PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
        PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
        PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
        PRISMA_INTROSPECTION_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/introspection-engine";
        PRISMA_FMT_BINARY = "${pkgs.prisma-engines}/bin/prisma-fmt";
        PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING = "1";
    };

    script = ''
      node ${inputs.signal_server.packages."x86_64-linux".default}
    '';
      # npm run migrate # we need to find a way to run migrations in through systemd

      serviceConfig = {
          User = "${user}";
          Restart = "on-failure";
      };

  };

  systemd.timers."signal-server" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
        OnBootSec = "20";
        Unit = "signal-server.service";
        Restart = "on-failure";
    };
  };

}