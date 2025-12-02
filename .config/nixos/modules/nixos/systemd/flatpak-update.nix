{
  pkgs,
  config,
  lib,
  ...
}: {
  systemd = {
    timers = {
      "flatpak-update" = {
        wantedBy = ["timers.target"];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "flatpak-update.service";
        };
      };
    };
    services = {
      flatpak-update = {
        enable = true;
        description = "update flatpaks";
        unitConfig = {
          Type = "oneshot";
        };
        serviceConfig = {
          User = "root";
          ExecStartPre = "${pkgs.bash}/bin/bash -c 'until ${pkgs.iputils.out}/bin/ping -c 1 9.9.9.9; do sleep 10; done;'";
          ExecStart = "${pkgs.flatpak}/bin/flatpak update -y";
          ExecStartPost = "${pkgs.libnotify}/bin/notify-send 'Flatpak Update completed successfully'";
        };
        wantedBy = ["multi-user.target"];
      };
    };
  };
}
