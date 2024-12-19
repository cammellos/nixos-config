self: super: {
  kitty-scrollback = super.vimUtils.buildVimPlugin {
    pname = "kitty-scrollback.nvim";
    version = "v5.0.0";

    src = super.fetchFromGitHub {
      owner = "mikesmithgh";
      repo = "kitty-scrollback.nvim";
      rev = "v6.1.0";
      hash = "sha256-qCeAnP7kRi7Vh98YMymrWGZqFUCVewpYHYkwnZL6V5w=";
    };

    meta = with super.lib; {
      description = "😽 Open your Kitty scrollback buffer with Neovim. Ameowzing!";
      homepage = "https://github.com/mikesmithgh/kitty-scrollback.nvim";
      platforms = platforms.all;
    };
  };
}
