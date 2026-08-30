{ pkgs, ... }:

{
  # Dev environment para el proyecto backend - .NET 7 (EOL/inseguro, permitido)
  # Equivalente a flake-example/backend/flake.nix
  packages = [
    pkgs.dotnet-sdk_7
  ];

  # Permitir paquetes inseguros (dotnet SDK 7 ya no recibe soporte)
  # devenv hereda la config de allowed-insecure-packages de la config de nix
}
