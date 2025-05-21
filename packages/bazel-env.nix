{
  lib,
  buildFHSEnv,
  bazelisk,
  bazel-buildtools,
  bash-completion,
  optional-shell-completion ? null,
  zlib,
  name ? "bazel-env",
  extraPkgs ? [ ],
}:
buildFHSEnv {
  inherit name;

  targetPkgs =
    _pkgs:
    [
      bazelisk
      bazel-buildtools
      zlib
    ]
    ++ extraPkgs
    ++ lib.optional (optional-shell-completion != null) optional-shell-completion
    ++ lib.optional (optional-shell-completion == null) [ bash-completion ];

  extraBuildCommands = ''
    ln -s /usr/bin/bazelisk $out/usr/bin/bazel
  '';

  runScript = "bash -l";

  meta = {
    description = "Shell environment for building Bazel projects";
    mainProgram = name;
  };
}
