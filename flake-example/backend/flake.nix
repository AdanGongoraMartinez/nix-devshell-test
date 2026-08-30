{
  description = "Dev shell para el proyecto backend - .NET 7 (EOL/inseguro, permitido)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.permittedInsecurePackages = [
          "dotnet-sdk-7.0.410"
          "dotnet-sdk-wrapped-7.0.410"
        ];
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pkgs.dotnet-sdk_7 ];
      };
    };
}