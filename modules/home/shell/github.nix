{pkgs, ...}: {
  programs.gh = {
    enable = true;

    extensions = with pkgs; [gh-dash gh-eco gh-enhance];

    settings = {
      telemetry = "disabled";
    };
  };
}
