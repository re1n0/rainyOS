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
    description = "Prefetch and compute SHA256 of a git repository";
  };
}
