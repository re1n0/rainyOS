{ lib
, linkFarm
, fetchurl
, fetchgit
, runCommandLocal
, zig
, name ? "zig-packages"
,
}:
with builtins;
with lib;
let
  unpackZigArtifact =
    { name
    , artifact
    ,
    }:
    runCommandLocal name
      {
        nativeBuildInputs = [ zig ];
      }
      ''
        hash="$(zig fetch --global-cache-dir "$TMPDIR" ${artifact})"
        mv "$TMPDIR/p/$hash" "$out"
        chmod 755 "$out"
      '';

  fetchZig =
    { name
    , url
    , hash
    ,
    }:
    let
      artifact = fetchurl { inherit url hash; };
    in
    unpackZigArtifact { inherit name artifact; };

  fetchGitZig =
    { name
    , url
    , hash
    ,
    }:
    let
      parts = splitString "#" url;
      url_base = elemAt parts 0;
      url_without_query = elemAt (splitString "?" url_base) 0;
      rev_base = elemAt parts 1;
      rev = if match "^[a-fA-F0-9]{40}$" rev_base != null then rev_base else "refs/heads/${rev_base}";
    in
    fetchgit {
      inherit name rev hash;
      url = url_without_query;
      deepClone = false;
    };

  fetchZigArtifact =
    { name
    , url
    , hash
    ,
    }:
    let
      parts = splitString "://" url;
      proto = elemAt parts 0;
      path = elemAt parts 1;
      fetcher = {
        "git+http" = fetchGitZig {
          inherit name hash;
          url = "http://${path}";
        };
        "git+https" = fetchGitZig {
          inherit name hash;
          url = "https://${path}";
        };
        http = fetchZig {
          inherit name hash;
          url = "http://${path}";
        };
        https = fetchZig {
          inherit name hash;
          url = "https://${path}";
        };
      };
    in
    fetcher.${proto};
in
linkFarm name [
  {
    name = "pixman-0.4.0-dev-LClMn0eVAAAlXnMK-MVBZkOG0urNdOPGVQdaGecXPM5O";
    path = fetchZigArtifact {
      name = "pixman";
      url = "git+https://codeberg.org/ifreund/zig-pixman#387f04a0289a69d159c88b5f70396ec12a8ddb00";
      hash = "sha256-0j15PIfdamr3+SBeOR61frj9shYSoUs36grg/ZztctM=";
    };
  }
  {
    name = "zigimg-0.1.0-8_eo2h6XEgAR6UkBiCtWECcml0gtx0oIXE3MX7sPCZof";
    path = fetchZigArtifact {
      name = "zigimg";
      url = "https://github.com/zigimg/zigimg/archive/refs/tags/zigimg_zig_0.14.1.tar.gz";
      hash = "sha256-Cv+Mjw+r0ldK7NuG+CuLBQYhuT/D4NPip3diNRCotH8=";
    };
  }
  {
    name = "wayland-0.3.0-lQa1kjPIAQDmhGYpY-zxiRzQJFHQ2VqhJkQLbKKdt5wl";
    path = fetchZigArtifact {
      name = "wayland";
      url = "https://codeberg.org/ifreund/zig-wayland/archive/v0.3.0.tar.gz";
      hash = "sha256-xU8IrETSFOKKQQMgwVyRKLwGaek4USaKXg49S9oHSTQ=";
    };
  }
]
