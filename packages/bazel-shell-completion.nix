{
  stdenv,
  fetchFromGitHub,
  bazel-base-env,
  version ? "8.1.1",
  sha256 ? "sha256-jIlIv/Xsq6xRDAD47BQAhYtM5dnlIDVydq5t2FyYnvw=",
  outputHash ? "sha256-3srOsu28PBq7jibzK8VALFQ4wYrSCsaxL4TvNKpibLM=",
}:
stdenv.mkDerivation {
  pname = "bazel-shell-completion";
  inherit version;
  src = fetchFromGitHub {
    owner = "bazelbuild";
    repo = "bazel";
    rev = version;
    inherit sha256;
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
  inherit outputHash;
}
