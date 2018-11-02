# Made for my server.

# TODO: These need to manually checked out at the right revision. Make them thunks?
let
  # sridca = (import /home/srid/run/srid.ca {port = "9005";});
in
{ config, pkgs, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/nixos-in-place.nix
    ./nix/base.nix
    ./nix/home.nix
    # ./nix/dev.nix
    # ./myobsidian/nixos-configuration/cache.nix
  ];

  boot.cleanTmpDir = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  networking.hostName = "tinix";
  services.openssh = {
    enable = true;
    ports = [22];
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
  users.extraUsers.srid = {
    isNormalUser = true;
    extraGroups = [ "wheel" "lxd" ];
    openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDxb8ZoHT4EYdGjSslIUMSFrsoRh/4cdRJXBgS0878Kv/rDRR+f33bh9Hunmx0m78g5bG3/b6C4AMmfcqgw7XvT6yuW0NGjKQeOQtCX6FSu5F+cEv63r7FSjAXEQ6FkJHaFELG2f1wIU43mCVTutAQsiLy0a7NaH7EyxCk1OUXN4FByd2slqGPeLfDEjNQLGiZaYrG4VEfkl1jlgSHWK9ryiahp9IuR4mOTtwRf7fl4DoCAKpEY5jGNZJTe2HubzMAjtxSVcR5KWd7kJYVLw3SsA3NC8o8k9K0rFj2WDKHst0dpBfYjPTYnWZAu3hytrTxS/IB87XUtFjBwQhQk59b srid@MacBook-Pro-de-Sridhar.local"
    ];
  };

  environment.systemPackages = with pkgs; [
  ];

  # systemd.services.sridca = sridca.unit;

  # My apps
  services.nginx = {
    enable = false;
    user = "srid";
    # virtualHosts."www.srid.ca" = sridca.vhost;
    # TODO: Port these over like srid.ca
    virtualHosts."slownews.srid.ca"= {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3001";
      };
    };
    virtualHosts."riceneggs.srid.ca" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8001";
      };
    };
  };

  security.acme.certs = {
    #"www.srid.ca".email = "srid@srid.ca";
    #"slownews.srid.ca".email = "srid@srid.ca";
    #"riceneggs.srid.ca".email = "srid@srid.ca";
  };
}