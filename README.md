# freebuff-flake

Run Freebuff on NixOS.

One-shot (no install):
```
nix run github:YOUR_USER/freebuff-flake
​```

Install into your profile:
```
nix profile install github:YOUR_USER/freebuff-flake
```

Add to your NixOS Flake:
```
freebuff.url = "github:YOUR_USER/freebuff-flake";

environment.systemPackages = [
  inputs.freebuff.packages.${pkgs.system}.default
];
```

Home Manager:
```
home.packages = [
  inputs.freebuff.packages.${pkgs.system}.default
];
```
