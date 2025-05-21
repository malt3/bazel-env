{
  description = "An collection of shell environment containing Bazel, Buck2, and related tools";
  
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

  outputs = {self, nixpkgs}:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
	packages.x86_64-linux = import ./packages pkgs;
  };
}
