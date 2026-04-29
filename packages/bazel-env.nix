{
  lib,
  buildFHSEnv,
  bazelisk,
  bazel-buildtools,
  bash-completion,
  coreutils,
  optional-shell-completion ? null,
  zlib,
  zip,
  name ? "bazel-env",
  runScript ? "bash -l",
  extraPkgs ? [ ],
}:
let
  coreutilsFHS = coreutils.overrideAttrs (o: {
    pname = o.pname + "-fhs";
    patches = (o.patches or []) ++ [
      ./env-use-fhs-path.patch
    ];
  });
in
buildFHSEnv {
  inherit name;
  inherit runScript;

  targetPkgs =
    _pkgs:
    [
      bazelisk
      bazel-buildtools
      zlib
      zip
    ]
    ++ extraPkgs
    ++ lib.optional (optional-shell-completion != null) optional-shell-completion
    ++ lib.optional (optional-shell-completion == null) bash-completion;

  extraBuildCommands = ''
    ln -s /usr/bin/bazelisk $out/usr/bin/bazel
    ln -sf ${lib.getBin coreutilsFHS}/bin/env $out/usr/bin/env
  '';

  meta = {
    description = "Shell environment for building Bazel projects";
    mainProgram = name;
  };
}
