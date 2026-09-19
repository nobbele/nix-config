{ den, ... }:
{
    den.aspects.alice = {
        includes = [ 
            den.batteries.primary-user
            den.aspects.niri
        ];

        nixos = { pkgs, ... }: {            
            users.users."alice" = {
                description = "Alice Ingmarsson";
                packages = with pkgs; [
                    kdePackages.kate
                ];
            };
        };

        homeManager = { pkgs, ... }: {
            home.packages = with pkgs; [
                equibop
                bitwarden-desktop
            ];

            programs.vscode.enable = true;
        };
    };
}
