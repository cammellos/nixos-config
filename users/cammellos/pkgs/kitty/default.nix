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
      ".local/bin/launch-kitty-scrollback.sh".source = ./launch-kitty-scrollback.sh;
      ".config/kitty/launch.conf".source = ./launch.conf;
    };

    programs.kitty = {
      enable = true;
      themeFile = "Nord";
      font = {
        name = "Inconsolata Nerd Font Mono";
        size = 12.0;
      };
      settings = {
        background_opacity = "0.95";
        copy_on_select = true;
      };
      extraConfig = ''

        shell fish
        shell_integration enabled

        # kitty-scrollback.nvim Kitten alias
        action_alias kitty_scrollback_nvim kitten ${pkgs.kitty-scrollback}/python/kitty_scrollback_nvim.py

        map alt+y previous_tab
        map alt+o next_tab
        map ctrl+t new_tab_with_cwd
        map ctrl+w close_tab
        # Browse scrollback buffer in nvim
        map kitty_mod+h kitty_scrollback_nvim
        # Browse output of the last shell command in nvim
        map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
        # Show clicked command output in nvim
        mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output

      '';
    };
  };
}
