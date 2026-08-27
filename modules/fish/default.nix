{mkTarget, ...}:
mkTarget "fish" {
  tags = ["fish"];
  description = "fish shell";

  nixos = {
    config,
    pkgs,
    ...
  }: {
    users.users.${config.rainy.settings.username}.shell = pkgs.fish;

    programs.fish.enable = true;
  };

  hm = {pkgs, ...}: {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting "" # Disable greeting

        set -Ux fifc_editor v

        set -Ux FZF_DEFAULT_OPTS "--bind=tab:down,shift-tab:up,ctrl-space:toggle"
      '';

      plugins = with pkgs.fishPlugins;
        map
        (pkg: {
          name = pkg.pname;
          inherit (pkg) src;
        })
        [
          puffer
          fifc
          git-abbr
          plugin-sudope
          spark
        ];
    };
  };
}
