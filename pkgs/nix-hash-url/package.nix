{
  lib,
  writeShellApplication,
  nix-prefetch-git,
}:
writeShellApplication {
  name = "nix-hash-url";

  runtimeInputs = [
    nix-prefetch-git
  ];

  text = # bash
    ''
      POSITIONAL_ARGS=()
      UNPACK=""

      while [[ $# -gt 0 ]]; do
        case $1 in
          --unpack)
            UNPACK="--unpack"
            shift
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

      PREFETCH="nix-prefetch-url $UNPACK --quiet ''${POSITIONAL_ARGS[0]}"

      OUTPUT=$(eval "$PREFETCH")

      HASH=$(echo "$OUTPUT" | tail -n 1)

      nix hash to-sri sha256:"$HASH"
      exit 0
    '';

  meta = {
    description = "Prefetch and compute SHA256 of a file fetched from an URL";
    maintainers = with lib.maintainers; [
      rein
    ];
    mainProgram = "nix-hash-url";
  };
}
