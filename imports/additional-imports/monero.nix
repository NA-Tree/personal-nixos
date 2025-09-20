{...}:
{

    services.xmrig = {

        enable = true;

        settings = {
            autosave = true;
            cpu = true;
            opencl = false;
            cuda = false;
            pools = [
                {
                url = "pool.supportxmr.com:443";
                user = "your-wallet";
                keepalive = true;
                tls = true;
                }
            ]
        }
    }

}