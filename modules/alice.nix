{ den, ... }:
{
    den.aspects.alice = {
        includes = [ 
            den.batteries.primary-user
            den.aspects.zsh
            den.aspects.shell-replacements
        ];

        nixos = { pkgs, ... }: {            
            users.users."alice" = {
                description = "Alice Ingmarsson";
                packages = with pkgs; [
                    kdePackages.kate
                ];
            };

            programs.steam.enable = true;

            environment.systemPackages = with pkgs; [
                pciutils
            ];
        };

        homeManager = { pkgs, ... }: {
            home.packages = with pkgs; [
                equibop
                bitwarden-desktop
                nixd
            ];

            programs.vscode.enable = true;

            programs.foot = {
                enable = true;
                server.enable = true;
            };
        };

        provides.desktop-alpha = {
            nixos = {
                services.displayManager.autoLogin.user = "alice";
            };

            homeManager = { pkgs, ... }: {
                home.packages = with pkgs; [
                    faugus-launcher
                ];
            };
        };

        provides.ideapad = {
            includes = [
                den.aspects.niri
            ];
        };
    };
}
