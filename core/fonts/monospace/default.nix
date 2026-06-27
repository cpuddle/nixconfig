{ pkgs }:

[
    (import ./jetbrains-mono.nix { inherit pkgs; })
    (import ./iosevka.nix { inherit pkgs; })
    (import ./iosevka-term-slab.nix { inherit pkgs; })
]
