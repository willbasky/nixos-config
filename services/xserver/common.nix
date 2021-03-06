{ config, pkgs, ... }:
{
    services.xserver = {
        videoDrivers = [ "modesetting" "intel" ];
        desktopManager = {
            xterm.enable = false;
            gnome3.enable = true;
            default = "none";
        };
        displayManager = {
            lightdm.enable = true;
            gdm.enable = false;
            sessionCommands = ''
              ${pkgs.xlibs.xmodmap}/bin/xmodmap /etc/Xmodmaprc
              ${pkgs.xlibs.xmodmap}/bin/xmodmap -e "clear Lock"

              export CURRENT_WM=${config.services.xserver.windowManager.default}
              export TZ="${config.time.timeZone}"

              ${pkgs.wmname}/bin/wmname LG3D

              source ~/common_settings

              ${pkgs.xorg.xrdb}/bin/xrdb -merge .Xresources
              arbtt-capture & # installed nondeclaratively, is broken otherwise
            '';
        };
        windowManager = {
            default = "xmonad";
            xmonad = {
                enable = true;
                enableContribAndExtras = true;
                extraPackages = p: [ p.taffybar p.dbus p.monad-logger p.lens ];
            };
            #default = "stumpwm";
            #stumpwm.enable = true;
        };
        enable = true;
        xkbOptions = "caps:none";
        layout = "us,ru";
        libinput = {
            enable = true;
            naturalScrolling = true;
            disableWhileTyping = true;
            tappingDragLock = false;
            accelSpeed = "0.6";
        };
    };

    services.autorandr = {
        enable = true;
        defaultTarget = "mobile";
    };

    services.compton = {
        enable = true;
        backend = "glx";
        vSync = "opengl-swc";
        opacityRules = [];
        package = pkgs.compton-git;
    };

    nixpkgs.config.dmenu.enableXft = true;

    environment.systemPackages = with pkgs; [
        arandr
        dmenu2
        edid-decode
        gmrun
        haskellPackages.xmobar
        haskellPackages.yeganesh
        i3lock-color
        taffybar
        xclip
        xdotool
        xlibs.xev
        xlibs.xmodmap
        xlibs.xprop
        xorg.xdpyinfo
        xorg.xhost
        xosd

        gnome3.gnome-tweak-tool
    ];
}
