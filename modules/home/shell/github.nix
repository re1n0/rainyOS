{pkgs, ...}: {
  programs.gh = {
    enable = true;

    extensions = with pkgs; [gh-dash gh-eco gh-enhance];

    gitCredentialHelper.enable = false;

    settings = {
      telemetry = "disabled";
    };
  };
}
