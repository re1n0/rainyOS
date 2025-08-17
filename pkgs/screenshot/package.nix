{
  writeShellApplication,
  grim,
  wl-clipboard,
  libnotify,
  slurp,
}:
writeShellApplication {
  name = "screenshot";

  runtimeInputs = [
    grim
    wl-clipboard
    libnotify
    slurp
  ];

  text = # bash
    ''
      DATE="$(date +'%y-%m-%d_%H:%M:%S')"
      DIR="$HOME/Pictures/screenshots"
      PIC="$DIR/$DATE.png"

      [ ! -d "$DIR" ] && mkdir -pv "$DIR"

      full() {
        grim "$PIC"
      }

      crop() {
        grim -g "$(slurp)" "$PIC"
      }

      abort() {
        notify-send -a "Screenshot info" -i dialog-error "Screenshot" "aborted"
        exit 1
      }
        case "$1" in
      --full)
        full || abort
        wl-copy < "$PIC"
        notify-send -u low -a Screenshot -i "$PIC" "Copied to clipboard" "$PIC"
        ;;
      --crop)
        crop || abort
        wl-copy < "$PIC"
        notify-send -u low -a Screenshot -i "$PIC" "Copied to clipboard" "$PIC"
        ;;
      esac
    '';

  meta = {
    description = "Make a screenshot of the full screen or a selected part";
    mainProgram = "screenshot";
  };
}
