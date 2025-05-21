{ pkgs, ... }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs // packages);
  packages = rec {
    bazel-shell-completion = callPackage ./bazel-shell-completion.nix { };
    bazel-base-env = callPackage ./bazel-env.nix { };
    bazel-env = callPackage ./bazel-env.nix { optional-shell-completion = bazel-shell-completion; };
    bazel-full-env = bazel-env.override {
      extraPkgs = [
        pkgs.python3
        pkgs.clang_19
        pkgs.gcc14
        pkgs.perl # to run BuildBuddy from source
      ];
      name = "bazel-full-env";
    };
    buck-env = callPackage ./buck-env.nix { };
  };
in
packages
