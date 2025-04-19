{ pkgs, ... }:

{
  systemd.services."backupToS3" = {
    description = "Backup to local S3";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = "/home/nick/scripts/backup_to_s3.sh";
      Environment = "PATH=/run/current-system/sw/bin";
    };
  };

  systemd.services."backupToSidsS3" = {
    description = "Backup to sids S3";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = "/home/nick/scripts/backup_to_sids_s3.sh";
      Environment = "PATH=/run/current-system/sw/bin";
    };
  };

  systemd.services."jvvnl" = {
    description = "Monitor JVVNL grid";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      User = "root";
      ExecStart = "/home/nick/scripts/nut.sh";
      Environment = "PATH=/run/current-system/sw/bin";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services."piholeshim" = {
    description = "Setup macvlan interface piholeshim";
    after = [ "network.target" ];
    wants = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.iproute2}/bin/ip link add piholeshim link enp3s0 type macvlan mode bridge";
      ExecStartPost = [
        "${pkgs.iproute2}/bin/ip addr add 10.29.74.54/32 dev piholeshim"
        "${pkgs.iproute2}/bin/ip link set piholeshim up"
        "${pkgs.iproute2}/bin/ip route add 10.29.74.55/32 dev piholeshim"
      ];
      ExecStop = "${pkgs.iproute2}/bin/ip link del piholeshim";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Define timers for the above services here
  # OnCalendar uses format: <dayofweek> y-m-d h:m:s
  systemd.timers."schedule-s3-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "backupToS3.service";
      OnCalendar = [
        "*-*-* 5:00:00"
        "*-*-* 17:00:00"
      ];
      Persistent = true;
    };
  };

  systemd.timers."schedule-sids-s3-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "backupToSidsS3.service";
      OnCalendar = [
        "*-*-* 5:10:00"
        "*-*-* 17:10:00"
      ];
      Persistent = true;
    };
  };
}
