{ ... }:

let
    sopsFile = ../../secrets.yaml;
in

{
    sops.secrets."email-ms-client-id" = {
        inherit sopsFile;
        owner = "collin";
    };

    sops.secrets."email-ms-client-secret" = {
        inherit sopsFile;
        owner = "collin";
    };
}
