{
  buildFHSEnv,
  buck2,
  bazel-buildtools,
  bash-completion,
  clang_19,
  lld_19,
  cargo,
  rustc,
  zlib,
  name ? "buck-env",
  extraPkgs ? [ ],
}:
buildFHSEnv {
  inherit name;

  targetPkgs =
    _pkgs:
    [
      buck2
      bazel-buildtools
      clang_19
      lld_19
      cargo
      rustc
      zlib
      bash-completion
    ]
    ++ extraPkgs;
  runScript = "bash -l";

  meta = {
    description = "Shell environment for building Buck projects";
    mainProgram = name;
  };
}
