{...}:
{

    services.xmrig = {

        enable = true;

        settings = builtins.fromJSON( builtins.readFile( ../../resources/mining.json ) );
        
    };

}
