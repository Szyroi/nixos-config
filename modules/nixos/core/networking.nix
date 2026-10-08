{...}: {
  services = {
    samba-wsdd.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };

    openvpn.servers = {
      hbrsVpn = {
        config = "/etc/nixos/vpn/client.ovpn";
        autoStart = false;
      };
    };
  };

  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;

      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [
        53
        5353
        24727
      ];
    };
  };
}
