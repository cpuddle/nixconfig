{
    config,
    pkgs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        adcli
        oddjob
        samba4Full
        sssd
        krb5
        realmd
    ];

    environment.etc."samba/smb.conf".text = ''
        [global]
            workgroup = FRANKONET
            realm = FRANKONET.NET
            security = ads
            kerberos method = secrets and keytab
    '';

    security = {
        krb5 = {
            enable = true;
            settings = {
                libdefaults = {
                    udp_preference_limit = 0;
                    default_realm = "FRANKONET.NET";
                };
            };
        };
        pam = {
            krb5.enable = true;
            makeHomeDir.umask = "077";
            services.login.makeHomeDir = true;
            services.sshd.makeHomeDir = true;
            services.sddm.makeHomeDir = true;
        };
    };

    services = {
        nscd = {
            enable = true;
            config = ''
                server-user nscd
                enable-cache hosts yes
                positive-time-to-live hosts 0
                negative-time-to-live hosts 0
                shared hosts yes
                enable-cache passwd no
                enable-cache group no
                enable-cache netgroup no
                enable-cache services no
            '';
        };
        sssd = {
            enable = true;
            config = ''
                [sssd]
                domains = frankonet.net
                config_file_version = 2
                services = nss, pam

                [nss]
                override_shell = /run/current-system/sw/bin/bash

                [domain/frankonet.net]
                krb5_store_password_if_offline = True
                krb5_use_enterprise_principal = false
                cache_credentials = True
                krb5_realm = FRANKONET.NET
                realmd_tags = manages-system joined-with-samba
                id_provider = ad
                fallback_homedir = /home/%u
                ad_domain = frankonet.net
                use_fully_qualified_names = true
                ldap_id_mapping = false
                auth_provider = ad
                access_provider = ad
                chpass_provider = ad
                ad_gpo_access_control = permissive
                enumerate = false
            '';
        };
    };

    systemd = {
        services.realmd = {
            description = "Realm Discovery Service";
            wantedBy = ["multi-user.target"];
            after = ["network.target"];
            serviceConfig = {
                Type = "dbus";
                BusName = "org.freedesktop.realmd";
                ExecStart = "${pkgs.realmd}/libexec/realmd";
                User = "root";
            };
        };
    };
}
