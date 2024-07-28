{
  # This should match Nixpkgs commit in status-mobile.
  source ? builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8fd4097529b4a71e0de000c90c8c4279f534eada.zip";
    sha256 = "sha256:174p05mzfqk56l4lqvwkbqka4qi5imbd75xaaw4bzmr00bails9f";
  },
  pkgs ? import source {
    config = {
      allowUnfree = true;
    };
  },
}:

let
  inherit (pkgs) lib stdenv;
in
pkgs.mkShell {
  name = "status-go-shell";

  buildInputs =
    with pkgs;
    [
      git
      jq
      which
      go_1_19
      golangci-lint
      gopls
      go-bindata
      mockgen
      protobuf3_17
    ]
    ++ lib.optional stdenv.isDarwin xcodeWrapper;
}
