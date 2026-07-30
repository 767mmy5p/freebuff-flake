{
  description = "Freebuff CLI for Nix/NixOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          freebuff = pkgs.buildFHSEnv {
            name = "freebuff";
            targetPkgs =
              p: with p; [
                nodejs
                stdenv.cc.cc
                zlib
                openssl
                curl
                icu
                libgcc
                # extras some native bins probe for
                glib
                libsecret
                nss
                nspr
              ];
            runScript = "npx --yes freebuff@0.0.122";
          };
        in
        {
          default = freebuff;
          freebuff = freebuff;
        }
      );

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/freebuff";
        };
      });
    };
}
