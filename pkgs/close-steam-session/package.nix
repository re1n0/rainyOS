{
  writeShellApplication,
  steam-unwrapped,
}:
writeShellApplication {
  name = "steamos-session-select";

  runtimeInputs = [
    steam-unwrapped
  ];

  text = # bash
    ''
      steam -shutdown
    '';

  meta = {
    description = "Close Steam running in gamescope session via Switch to Desktop button";
  };
}
