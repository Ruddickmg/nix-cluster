{ config, lib, pkgs, ... }:
{
    options.services.tailscale.authKey = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = lib.literalExpression "tskey-examplekeyhere";
    };

    config = lib.mkIf config.services.tailscale.enable {

        # create a oneshot job to authenticate to Tailscale
        systemd.services.tailscale-autoconnect = {
            description = "Automatic connection to Tailscale";

            # make sure tailscale is running before trying to connect to tailscale
            after = [ "network-pre.target" "tailscale.service" ];
            wants = [ "network-pre.target" "tailscale.service" ];
            wantedBy = [ "multi-user.target" ];

            # set this service as a oneshot job
            serviceConfig.Type = "oneshot";

            # have the job run this shell script
            script = with pkgs; ''
              # wait for tailscaled to settle
              sleep 2

              # check if we are already authenticated to tailscale
              status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
              if [ $status = "Running" ]; then # if so, then do nothing
                exit 0
              fi

              # otherwise authenticate with tailscale
              ${tailscale}/bin/tailscale up -authkey ${config.services.tailscale.authKey}

              # set up tls certificates
              ${tailscale}/bin/tailscale cert ${config.networking.hostName}.tailbac0df.ts.net
            '';
        };

        # refresh tls certs once a month
        services.cron = {
            enable = true;
            systemCronJobs = [
                "*/0 0 1 * *      root    sudo tailscale cert ${config.networking.hostName}.tailbac0df.ts.net"
            ];
        };
    };
}