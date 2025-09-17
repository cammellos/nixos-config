{
  pkgs,
  config,
  unstable,
  user,
  ...
}:
{
  users.users."${user}".packages = with pkgs; [
    (unstable.elixir-ls)
    elixir_1_18
    lexical
  ];
}
