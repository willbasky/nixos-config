{ config, ... }:

{
    # TODO: dropbox / compare with syncthing
    # TODO: arbtt (broken)

    services.locate.enable = true;
    services.urxvtd.enable = true;
    services.journald.extraConfig = ''
        MaxRetentionSec=2day
    '';
    services.mpd.enable = true;
}
