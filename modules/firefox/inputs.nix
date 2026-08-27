{inputs, ...}: {
  flake-file.inputs = {
    firefox-addons = {
      type = "gitlab";
      owner = "rycee";
      repo = "nur-expressions";
      dir = "pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    glide = {
      type = "github";
      owner = "glide-browser";
      repo = "glide.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  flake.homeManagerModules.glide = inputs.glide.homeModules.default;
}
