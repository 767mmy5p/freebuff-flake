# freebuff-flake

Run [Freebuff](https://freebuff.com) on NixOS.

## One-shot (no install)

```bash
nix run github:767mmy5p/freebuff-flake
```

## Install into your profile

```bash
nix profile install github:767mmy5p/freebuff-flake
```

## Add to your NixOS flake

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    freebuff.url = "github:767mmy5p/freebuff-flake";
  };

  outputs = { self, nixpkgs, freebuff, ... }: {
    nixosConfigurations.yourHostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ({ pkgs, ... }: {
          environment.systemPackages = [
            freebuff.packages.${pkgs.system}.default
          ];
        })
      ];
    };
  };
}
```

## Add to Home Manager

```nix
home.packages = [
  inputs.freebuff.packages.${pkgs.system}.default
];
```

## Notes

- Needs flakes enabled (`nix-command` and `flakes`).
- First run may download Freebuff via `npx` (needs network).
- This flake wraps Freebuff in an FHS env so the prebuilt binary works on NixOS.
