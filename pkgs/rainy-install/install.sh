set -o errtrace -o errexit -o nounset -o pipefail

readonly C_RESET="\033[0m"
readonly C_BOLD="\033[1m"
readonly C_OK="\033[1;32m"     # green bold
readonly C_INFO="\033[1;34m"   # blue bold
readonly C_WARN="\033[1;33m"   # yellow bold
readonly C_ERR="\033[1;31m"    # red bold
readonly C_HDR="\033[1;37m"    # white bold

title()   { printf "%b\n" "${C_HDR}::${C_RESET} $*"; }
info()    { printf "%b\n" "${C_INFO}::${C_RESET} $*"; }
ok()      { printf "%b\n" "${C_OK}[ok]${C_RESET} $*"; }
warn()    { printf "%b\n" "${C_WARN}[warn]${C_RESET} $*"; }
err()     { printf "%b\n" "${C_ERR}[error]${C_RESET} $*" >&2; }

step()    { printf "%b\n" "${C_BOLD}==>${C_RESET} $*"; }

readonly CONFIG_REPO="re1n0/rainyos"
readonly FLAKE="github:${CONFIG_REPO}"
readonly MOUNT_DIR="/mnt"
readonly CONFIG_DIR="${MOUNT_DIR}/etc/nixos"

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || { err "Required command '$1' not found"; exit 1; }
}
require_cmd nix
require_cmd jq
require_cmd git
require_cmd disko
require_cmd nixos-facter

confirm() {
  local prompt="${1:-Are you sure?}"
  read -r -p "$prompt [y/N]: " ans
  case "$ans" in
    [Yy]|[Yy][Ee][Ss]) return 0 ;;
    *) return 1 ;;
  esac
}

step "Retrieving config list from flake: ${FLAKE}"
device_list=$(nix --extra-experimental-features "nix-command flakes" flake show --json "${FLAKE}" \
  | jq --raw-output '.nixosConfigurations | keys[]' 2>/dev/null || true)

if [[ -z "${device_list}" ]]; then
  err "No nixosConfigurations found in ${FLAKE} or 'nix' failed."
  exit 1
fi

PS3="$(printf '%b ' "${C_BOLD}Select device config to install:${C_RESET}") "
select device in $device_list "quit"; do
  case "${device:-}" in
    "quit")
      step "Aborting install"
      exit 0
      ;;
    "")
      err "Invalid selection '${REPLY}'"
      REPLY=""
      ;;
    *)
      step "Selected config: ${C_BOLD}${device}${C_RESET}"
      break
      ;;
  esac
done

step "Partitioning disk with disko"
readonly DISK_FILE="/tmp/disk.nix"
curl "https://raw.githubusercontent.com/${CONFIG_REPO}/master/hosts/${device}/partitioning.nix" -o "${DISK_FILE}"


if disko --mode destroy,format,mount "${DISK_FILE}"; then
  ok "Disk partitioning completed"
else
  err "disko failed"
  exit 1
fi

step "Cloning config repo to ${CONFIG_DIR}"

mkdir -p "$(dirname "${CONFIG_DIR}")"

if git clone "https://github.com/${CONFIG_REPO}.git" "${CONFIG_DIR}"; then
  ok "Cloned https://github.com/${CONFIG_REPO}.git"
  if git -C "${CONFIG_DIR}" remote set-url origin "git@github.com:${CONFIG_REPO}.git"; then
    ok "Set origin to SSH URL"
  else
    warn "Failed to set origin to SSH URL; keep HTTPS origin"
  fi
else
  err "git clone failed"
  exit 1
fi

step "Generating information about '${device}'"
readonly HOST_DIR="${CONFIG_DIR}/hosts/${device}"
readonly FACTER_FILE="${HOST_DIR}/facter.json"

if nixos-facter -o "${FACTER_FILE}"; then
  ok "Wrote information about '${device}' to ${FACTER_FILE}"
else
  err "nixos-facter failed"
  exit 1
fi

cd "${HOST_DIR}"
if git add .; then
  ok "Added facter.json to staged files"
else
  err "git add failed"
  exit 1
fi
cd

step "Installing NixOS"

if nixos-install --flake "git+file://${CONFIG_DIR}#${device}" --no-channel-copy --no-root-passwd; then
  ok "NixOS installation finished"
  step "Rebooting is recommended"
else
  err "nixos-install failed"
  exit 1
fi
