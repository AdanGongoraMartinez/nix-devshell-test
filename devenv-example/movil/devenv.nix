{ pkgs, ... }:

{
  # Dev environment para el proyecto movil - Flutter 3.38.3
  # Equivalente a flake-example/movil/flake.nix
  packages = [
    pkgs.flutter338
  ];
}
