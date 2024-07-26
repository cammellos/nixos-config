{pkgs ? import <nixpkgs> {}}:

let
  main = import /home/cammellos/documents/programming/status/status-go/nix {};
in pkgs.mkShell {
  name = "entr";
  buildInputs = with pkgs; [
    entr
  ];
  inputsFrom = [ main.shells.default ];
}
