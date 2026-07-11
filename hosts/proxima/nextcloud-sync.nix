{ config, pkgs, ... }:

let
  remoteUrl  = "https://nc.frankonet.net";
  remotePath = "/"; 
  syncUser   = "collin";
  syncGroup  = "users";                   
  syncHome   = "/home/collin";
  localDir   = "${syncHome}/Nextcloud";

  nextcloudSyncCmd = pkgs.writeShellScript "nextcloud-sync-cmd" ''
    set -euo pipefail
    exec ${pkgs.util-linux}/bin/flock -w 240 ${syncHome}/.nextcloud-sync.lock \
      ${pkgs.nextcloud-client}/bin/nextcloudcmd \
        -n --non-interactive \
        --path "${remotePath}" \
        "${localDir}" \
        "${remoteUrl}"
  '';
in
{
  environment.systemPackages = [ pkgs.nextcloud-client pkgs.watchexec ];

  systemd.tmpfiles.rules = [
    "d ${localDir} 0750 ${syncUser} ${syncGroup} -"
  ];

  sops.secrets."nextcloud/netrc" = {
    sopsFile = ../../secrets.yaml;
    owner = syncUser;
    group = syncGroup;
    mode = "0400";
    path = "${syncHome}/.netrc";
  };

  systemd.services.nextcloud-sync = {
    description = "Nextcloud one-shot sync (nextcloudcmd)";
    after = [ "network-online.target" "sops-nix.service" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = syncUser;
      Group = syncGroup;
      Environment = "HOME=${syncHome}";
      ExecStart = "${nextcloudSyncCmd}";
      TimeoutStartSec = "300";
    };
  };

  systemd.timers.nextcloud-sync = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "2min";
      OnUnitActiveSec = "15min";
      Unit = "nextcloud-sync.service";
    };
  };

  systemd.services.nextcloud-sync-watch = {
    description = "Watch local Nextcloud folder, sync on change";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "sops-nix.service" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "simple";
      User = syncUser;
      Group = syncGroup;
      Environment = "HOME=${syncHome}";
      Restart = "always";
      RestartSec = 10;
      ExecStart = ''
        ${pkgs.watchexec}/bin/watchexec \
          --watch ${localDir} \
          --debounce 10s \
          --on-busy-update=queue \
          --ignore '.sync_*.db*' \
          --ignore '._sync_*.db*' \
          --ignore '.csync_journal.db*' \
          --ignore '.owncloudsync.log*' \
          --ignore '*.~*' \
          --ignore '*.sync-conflict-*' \
          -- ${nextcloudSyncCmd}
      '';
    };
  };
}
