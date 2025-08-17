{ config, pkgs, ... }:

{
  hardware.keyboard.zsa.enable = true;
  users.users.ej.packages = with pkgs; [
    keymapp
  ];
}