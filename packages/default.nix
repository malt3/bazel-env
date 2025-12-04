{ pkgs, ... }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs // packages);
  packages = rec {
    bazel-shell-completion = callPackage ./bazel-shell-completion.nix { version = "8.4.2"; };
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
    bazel = bazel-env.override {
      name = "bazel";
      runScript = "bazel";
    };
    bazel-full = bazel-full-env.override {
      name = "bazel";
      runScript = "bazel";
    };
    buck-env = callPackage ./buck-env.nix { };
    buck2-fhs = buck-env.override {
      name = "buck2";
      runScript = "buck2";
    };
  };
in
packages
