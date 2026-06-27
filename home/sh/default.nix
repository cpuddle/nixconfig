{lib, config, pkgs, ... }:

{
    home = {
        packages = with pkgs; [
            fastfetch
        ];
        sessionVariables = {};
    };
    services.udiskie = {
        enable = true;
        automount = true;
        tray = "never";  # no tray icon needed
    };
    programs = {
        bash = {
            enable = true;
            enableCompletion = true;
            shellAliases = {
                "la" = "ls -lA";
                "ll" = "ls -ll";
                "ff" = "fastfetch";
                "rebuild" = "sudo nixos-rebuild switch --flake";
            };
            bashrcExtra = ''
                PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null); [ -n "$PS1_CMD1" ] && PS1_CMD1="($PS1_CMD1)"';
                PS1='\[\033[01;32m\](\u@\h) \[\033[01;33m\]\w \[\033[01;31m\]''${PS1_CMD1}\n\[\033[01;32m\]$\[\033[01;39m\] ' 
                PS2='>> '
                eval "$(direnv hook bash)"
            '';
        };
    };
}
