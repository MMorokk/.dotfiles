{config, pkgs, ...}:
{
  hardware.keyboard.qmk.enable = true;
  environment.systemPackages = with pkgs; [
    qmk
    qmk_hid
    qmk-udev-rules
  ];
}