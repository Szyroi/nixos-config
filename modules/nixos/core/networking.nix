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
<<<<<<< HEAD

=======
    useDHCP = false;
    interfaces.eno1.useDHCP = false;
>>>>>>> e25a0bea59fd3ffdc387c1d903f981f1b7a72e04
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
