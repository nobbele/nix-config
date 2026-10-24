{ den, ... }:
{
    den.aspects.alice = {
        includes = [ 
            den.batteries.primary-user
            den.aspects.zsh
            den.aspects.shell-replacements
            den.aspects.motd
        ];

        nixos = { pkgs, ... }: {   
            users.users."alice" = {
                description = "Alice Ingmarsson";
            };

            programs.steam.enable = true;

            environment.systemPackages = with pkgs; [
                pciutils
            ];

            services.sunshine = {
                enable = true;
                autoStart = false;
                capSysAdmin = true;
                openFirewall = true;
            };
        };

        homeManager = { pkgs, ... }: {
            home.packages = with pkgs; [
                kdePackages.kate
                unrar
                equibop
                bitwarden-desktop
                nixd
                tokei

                google-chrome
            ];

            programs.vscode.enable = true;

            programs.foot = {
                enable = true;
                server.enable = true;
            };
        };

        provides.desktop-alpha = {
            includes = [
                den.aspects.stepmania
            ];

            nixos = {
                services.displayManager.autoLogin.user = "alice";
            };
        };

        provides.ideapad = {
            includes = [
                den.aspects.niri
            ];
        };
    };
}
