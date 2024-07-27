{config, pkgs, user, ...}:
{
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    fish
  ];

  home-manager.users.${user} = {
    programs.fish = {
    enable = true;
    interactiveShellInit = "
    set fish_greeting
    ";
    shellAbbrs = {
      gst = "git status";
      gco = "git checkout";
      gl = "git pull --rebase";
      gp = "git push";
      gre = "git rebase";
      ga = "git add";
      gdf = "git diff";
      glo = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";
      vi = "nvim";
      vim = "nvim";
    };
  };

    home.activation = {
      "set-fish-prompt" = ''
        #!/bin/sh
        ${pkgs.fish}/bin/fish -c "yes | fish_config prompt save arrow; exit 0"
      '';
    };

  };
}
