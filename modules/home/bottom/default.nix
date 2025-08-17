let
  colors = import ./colors.nix;
in
{
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        hide_avg_cpu = true;
        group_processes = true;
        case_sensitive = true;
        enable_gpu = true;
      };
      inherit colors;
    };
  };
}
