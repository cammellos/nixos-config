{
  config,
  pkgs,
  user,
  ...
}:
{
  #nixpkgs.config.input-fonts.acceptLicense = true;

  home-manager.users."${user}" = {
    home.file = {
      ".local/bin/remote-kitty.sh".source = ./remote-kitty.sh;
      ".config/kitty/launch.conf".source = ./launch.conf;
    };

    programs.kitty = {
      enable = true;
      themeFile = "Nord";
      font = {
        name = "JetBrainsMono Nerd Font Propo";
        size = 12.0;
      };
      settings = {
        background_opacity = "0.95";
        copy_on_select = true;
      };
      extraConfig = ''

        shell ${pkgs.fish}/bin/fish
        shell_integration enabled

        map alt+y previous_tab
        map alt+o next_tab
        map cmd+o next_tab
        map cmd+y previous_tab
        map ctrl+t new_tab_with_cwd
        map ctrl+w close_tab
      '';
    };
  };
}
