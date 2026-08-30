{ pkgs, ... }:

{
  # Dev environment para el proyecto frontend - Node.js 20
  # Equivalente a flake-example/frontend/flake.nix
  packages = [
    pkgs.nodejs_20
  ];
}
