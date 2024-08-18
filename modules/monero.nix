{config, pkgs, ...}:
{
  services.monero = {
    enable = true;
    dataDir = "/home/morok/Storage/XMR";
    extraNodes = [
      "xmr-node.cakewallet.com:18081"
    ];
  };
}