{
  lib,
  stdenv,
  fetchFromGitHub,
  bazel-base-env,
  version ? "8.4.2",
}:
let
  versions = import ./bazel-shell-completion-versions.nix;
  versionData = versions.${version} or {
    sha256 = lib.fakeHash;
    outputHash = lib.fakeHash;
  };
in
stdenv.mkDerivation {
  pname = "bazel-shell-completion";
  inherit version;
  src = fetchFromGitHub {
    owner = "bazelbuild";
    repo = "bazel";
    rev = version;
    sha256 = versionData.sha256;
  };
  HOME = "/tmp";
  USE_BAZEL_VERSION = version;
  installPhase = ''
    mkdir -p $out/share/bash-completion/completions
    cat scripts/bazel-complete-header.bash > $out/share/bash-completion/completions/bazel
    cat scripts/bazel-complete-template.bash >> $out/share/bash-completion/completions/bazel
    ${bazel-base-env}/bin/bazel-env -c "bazelisk help completion" >>  $out/share/bash-completion/completions/bazel
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = versionData.outputHash;
}
