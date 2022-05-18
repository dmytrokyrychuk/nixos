{ config, custom, inputs, pkgs, ... }:
{
  imports = [
    (import "${inputs.self}/systems/raspi4" {
      hostname = "raspi-test";
      ip = "10.7.89.99";
      inherit inputs pkgs;
    })
    (import "${inputs.self}/modules/restic-server-client" {
      time = "11:30"; inherit config custom inputs pkgs;
    })
    "${inputs.self}/modules/nginx-acme-base"
    "${inputs.self}/modules/docker"
    "${inputs.self}/modules/haproxy"
  ];

  services.nginx = {
    virtualHosts = {
      "2li.ch" = {
        serverAliases = [ "www.2li.ch" ];
        enableACME = true;
        forceSSL = true;
        listen = [{ port = 4433; addr = "127.0.0.1"; ssl = true; }];
        locations."/" = {
          proxyPass = "http://127.0.0.1:8080";
          proxyWebsockets = true; # needed if you need to use WebSocket
        };
      };
      "heimdall.2li.ch" = {
        enableACME = true;
        forceSSL = true;
        listen = [{ port = 4433; addr = "127.0.0.1"; ssl = true; }];
        locations."/" = {
          proxyPass = "http://127.0.0.1:8081";
          proxyWebsockets = true; # needed if you need to use WebSocket
        };
      };
      "rss-bridge.2li.ch" = {
        enableACME = true;
        forceSSL = true;
        listen = [{ port = 4433; addr = "127.0.0.1"; ssl = true; }];
        locations."/" = {
          proxyPass = "http://127.0.0.1:8082";
          proxyWebsockets = true; # needed if you need to use WebSocket
        };
      };
    };
  };
}
