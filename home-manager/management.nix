{ inputs, custom, pkgs, ... }:
{
  imports = [
    (import "${inputs.self}/home-manager/common" { inherit custom inputs; })
    # "${inputs.self}/home-manager/software/emacs"
    # "${inputs.self}/home-manager/software/email"
    "${inputs.self}/home-manager/software/fzf"
    "${inputs.self}/home-manager/software/git"
    # "${inputs.self}/home-manager/software/ssh"
    "${inputs.self}/home-manager/software/starship"
    "${inputs.self}/home-manager/software/vim"
  ];

  programs.git.userEmail = custom.email;

  programs.bash = {
    enable = true;
  };

}
