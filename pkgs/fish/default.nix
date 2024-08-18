{
  config,
  pkgs,
  user,
  ...
}:
{
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [ fish ];
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  home-manager.users.${user} = {
    programs.fish = {
      enable = true;
      interactiveShellInit = "
    set fish_greeting
    user_key_bindings
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
