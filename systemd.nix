{ config, pkgs, ... }:

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

  # Define timers for the above services here
  # OnCalendar uses format: <dayofweek> y-m-d h:m:s
  systemd.timers."schedule-s3-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "backupToS3.service";
      OnCalendar = [ "*-*-* 5:00:00" "*-*-* 17:00:00" ];
      Persistent = true;
    };
  };

  systemd.timers."schedule-sids-s3-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "backupToSidsS3.service";
      OnCalendar = [ "*-*-* 5:10:00" "*-*-* 17:10:00" ];
      Persistent = true;
    };
  };
}
