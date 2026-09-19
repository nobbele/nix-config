{ inputs, ... }:
{
    den.default.nixos = { pkgs, ... }: 
    let
        unstable = import inputs.nixpkgs-unstable {
            system = pkgs.stdenv.hostPlatform.system;
            config.allowUnfree = true;
        };
    in
    {
        system.stateVersion = "26.05";
        nixpkgs.config.allowUnfree = true;

        nix.settings.experimental-features = [ 
            "nix-command"
            "flakes"
        ];

        time.timeZone = "Europe/Stockholm";

        i18n.defaultLocale = "en_US.UTF-8";
        i18n.extraLocaleSettings = {
            LC_ADDRESS = "sv_SE.UTF-8";
            LC_IDENTIFICATION = "sv_SE.UTF-8";
            LC_MEASUREMENT = "sv_SE.UTF-8";
            LC_MONETARY = "sv_SE.UTF-8";
            LC_NAME = "sv_SE.UTF-8";
            LC_NUMERIC = "sv_SE.UTF-8";
            LC_PAPER = "sv_SE.UTF-8";
            LC_TELEPHONE = "sv_SE.UTF-8";
            LC_TIME = "sv_SE.UTF-8";
        };
        i18n.extraLocales = [
            "sv_SE.UTF-8/UTF-8"
            "en_US.UTF-8/UTF-8"
            "en_GB.UTF-8/UTF-8"
        ];

        console.keyMap = "sv-latin1";
        services.xserver.xkb = {
            layout = "se";
            variant = "nodeadkeys";
        };

        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        boot.kernelPackages = unstable.linuxPackages_latest;

        services.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };

        hardware.alsa.enablePersistence = true;

        networking.networkmanager.enable = true;

        services.xserver.enable = true;
        services.displayManager.sddm.enable = true;
        services.desktopManager.plasma6.enable = true;

        programs.nix-ld.enable = true;
        services.flatpak.enable = true;
        programs.appimage = {
            enable = true;
            binfmt = true;
        };

        programs.firefox.enable = true;

        environment.systemPackages = with pkgs; [
            vim
            wget
            git
            devenv
        ];
    };
}
