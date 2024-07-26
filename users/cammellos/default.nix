{ config, pkgs, ... }:

let
  user = import ./user.nix { inherit config pkgs; };
in
{
  imports = [ user ];
}
