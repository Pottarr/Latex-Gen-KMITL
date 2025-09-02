{
  description = "KMITL Report Generator for Latex written in Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "latex-gen-kmitl";
          version = "1.0.0";
          src = ./.;
          cargoSha256 = pkgs.lib.fakeSha256;
        };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/latex-gen";
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.rustc pkgs.cargo ];
        };
      });
}

