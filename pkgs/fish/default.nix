{
  config,
  pkgs,
  user,
  ...
}:
{
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [ fish ];

  users.users.${user}.shell = pkgs.fish;

  home-manager.users.${user} = {
    programs.fish = {
      enable = true;
      interactiveShellInit = "
    set fish_greeting
    if test -d /opt/homebrew
      # Homebrew is installed on MacOS
      /opt/homebrew/bin/brew shellenv | source
      set AWS_DEFAULT_PROFILE sts
    end

    if test /home/${user}/.config/sops-nix/secrets/open_api_key
      set OPEN_API_KEY (cat /home/${user}/.config/sops-nix/secrets/open_api_key)
    end

    user_key_bindings

    fish_add_path -a $HOME/.local/bin
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
        vi = "nvim";
        vim = "nvim";
      };
      functions = {
        fish_prompt = builtins.readFile ./functions/fish_prompt.fish;
        user_key_bindings = builtins.readFile ./functions/user_key_bindings.fish;
        nix-shell = builtins.readFile ./functions/nix-shell.fish;
      };
    };

  };
}
