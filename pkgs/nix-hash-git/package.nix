{
  lib,
  writeShellApplication,
  nix-prefetch-git,
  jq,
}:
writeShellApplication {
  name = "nix-hash-git";

  runtimeInputs = [
    nix-prefetch-git
    jq
  ];

  text = # bash
    ''
      POSITIONAL_ARGS=()
      REVISION=""

      while [[ $# -gt 0 ]]; do
        case $1 in
          --rev)
            REVISION="$2"
            shift 2
            ;;
          -*)
            echo "Unknown option: $1"
            exit 1
            ;;
          *)
            POSITIONAL_ARGS+=("$1")
            shift
            ;;
        esac
      done

      if [ "''${#POSITIONAL_ARGS[@]}" -eq 0 ]; then
        echo "No URL provided"
        exit 1
      fi

      PREFETCH="nix-prefetch-git --url ''${POSITIONAL_ARGS[0]} --quiet"

      if [ -n "$REVISION" ]; then
        PREFETCH+=" --rev $REVISION"
      fi

      HASH=$(eval "$PREFETCH | jq -r '.sha256'")

      nix hash to-sri sha256:"$HASH"
      exit 0
    '';

  meta = {
    description = "Prefetch and compute SHA256 of a git repository";
    maintainers = with lib.maintainers; [
      rein
    ];
    mainProgram = "nix-hash-git";
  };
}
