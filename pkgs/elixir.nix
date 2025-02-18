{
  pkgs,
  config,
  user,
  ...
}:
{
  users.users."${user}".packages = with pkgs; [ elixir-ls elixir_1_18 lexical ];
}
