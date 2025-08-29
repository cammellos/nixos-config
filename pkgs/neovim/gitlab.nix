{
  pkgs ? import <nixpkgs> {}
}:

let
  gitlabServer = pkgs.buildGoModule {
    pname = "gitlab-nvim-server";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "harrisoncramer";
      repo = "gitlab.nvim";
      rev = "e29909cd1064a7b53c3150bff49449a548dadf8d";
      hash = "sha256-f4kVkKM/O3h3bgTho7yCEsniRwvgIfAqSw6mXS01mb8=";
    };
    goPackagePath = "github.com/harrisoncramer/gitlab.nvim/cmd";
    vendorHash = "sha256-wYlFmarpITuM+s9czQwIpE1iCJje7aCe0w7/THm+524=";
  };
in
pkgs.vimUtils.buildVimPlugin {
    pname = "gitlab-nvim";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "harrisoncramer";
      repo = "gitlab.nvim";
      rev = "e29909cd1064a7b53c3150bff49449a548dadf8d";
      hash = "sha256-f4kVkKM/O3h3bgTho7yCEsniRwvgIfAqSw6mXS01mb8=";
    };

    dependencies = [
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.diffview-nvim
      pkgs.vimPlugins.dressing-nvim
    ];

    propagatedBuildInputs = [ gitlabServer ];
    doCheck = false;

    postInstall = ''
      cp -r $src/* $out/
      mkdir -p $out/cmd
      cp ${gitlabServer}/bin/cmd $out/cmd/bin
    '';
  }
