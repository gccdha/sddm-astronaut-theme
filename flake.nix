{
  description = "SDDM Astronaut theme by Keyitdev";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    #systems.url = "github:nix-systems/default-linux";
  };

  outputs = { self, nixpkgs, ... }:
  let
    version = builtins.substring 0 8 self.lastModifiedDate;
    eachSystem = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
    ];

  in
  {
    packages = eachSystem (system: {
      sddm-astro = nixpkgs.legacyPackages.${system}.callPackage ./sddm-astro.nix { inherit version; };
    });
    defaultPackage = eachSystem (system: self.packages.${system}.sddm-astro);
  };
}
