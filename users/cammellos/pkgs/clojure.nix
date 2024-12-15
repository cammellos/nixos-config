{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    leiningen
    clojure-lsp
    clj-kondo
  ];
}
