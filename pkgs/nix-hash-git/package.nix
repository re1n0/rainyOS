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

      while [[ $# -gt 0 ]]; do
        case $1 in
          --rev)
            REVISION="$2"
            shift
            shift
          ;;
          -*)
            echo "Unknown option $1"
            exit 1
          ;;
          *)
            POSITIONAL_ARGS+=("$1")
            shift 
          ;;
        esac
      done

      set -- "''${POSITIONAL_ARGS[@]}"

      if [ "$#" -eq 0 ]; then
        echo "No URL provided"
        exit 1
      fi

      PREFETCH="nix-prefetch-git --url $1 --quiet"

      [ -n "$REVISION" ] && PREFETCH+=" --rev $REVISION"

      PREFETCH+=" | jq -r '.sha256'"

      HASH=$(eval "$PREFETCH")

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
