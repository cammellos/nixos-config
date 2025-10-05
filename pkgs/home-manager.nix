{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "sha256:0q3lv288xlzxczh6lc5lcw0zj9qskvjw3pzsrgvdh8rl8ibyq75s";

  };
in
{
  imports = [ (import "${home-manager}/nixos") ];
}
