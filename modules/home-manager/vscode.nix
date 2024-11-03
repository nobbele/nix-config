{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # dracula-theme.theme-dracula
      # vscodevim.vim
      # yzhang.markdown-all-in-one
      ms-dotnettools.csharp
      csharpier.csharpier-vscode
      
    ]  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # {
      #   name = "remote-ssh-edit";
      #   publisher = "ms-vscode-remote";
      #   version = "0.47.2";
      #   sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      # }
    ];

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
  };
}