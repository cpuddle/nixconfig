{ lib, config, pkgs, ... }:

let
    cfg = config.myEmail;

    stateFile = "${config.xdg.stateHome}/email/last-notify";

    notifyScript = pkgs.writeShellApplication {
        name = "email-notify-new";
        runtimeInputs = [ pkgs.libnotify pkgs.findutils pkgs.gnugrep pkgs.gnused pkgs.coreutils ];
        text = ''
            statefile="${stateFile}"
            mkdir -p "$(dirname "$statefile")"

            if [ ! -f "$statefile" ]; then
                # First run: establish a baseline without notifying for
                # everything already in the maildir.
                touch "$statefile"
                exit 0
            fi

            find "${cfg.maildir}" -path '*/new/*' -type f -newer "$statefile" \
                | while IFS= read -r msg; do
                subject=$(grep -m1 -i '^Subject:' "$msg" | sed 's/^[Ss]ubject:[[:space:]]*//' || true)
                from=$(grep -m1 -i '^From:' "$msg" | sed 's/^[Ff]rom:[[:space:]]*//' || true)
                from_name=$(echo "$from" | sed -E 's/^"?([^"<]*)"?\s*<.*/\1/')
                notify-send --app-name="aerc" --icon=mail-unread \
                    "''${subject:-(no subject)}" "From: ''${from_name:-unknown sender}"
            done

            touch "$statefile"
        '';
    };
in
{
    config = lib.mkIf cfg.enable {
        home.packages = [ notifyScript ];
        services.mbsync.postExec = "${notifyScript}/bin/email-notify-new";
    };
}
