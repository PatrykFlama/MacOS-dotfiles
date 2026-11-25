{
  description = "Patryk's macOS setup: nix-darwin + home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nix-darwin,
      home-manager,
      ...
    }:
    let
      # Per-machine values live here (no git-ignored secrets file, no --impure).
      mkHost =
        {
          hostname,
          user,
          system ? "aarch64-darwin",
          # Absolute path of this repo on that machine; config/ is symlinked from here
          # so edits to dotfiles apply instantly, without a rebuild.
          dotfilesDir ? "/Users/${user}/workplace/MacOS-dotfiles",
          # Per-machine choices, independent of each other:
          #   windowManager: "aerospace" | "none"     (modules/darwin/wm/)
          #   launcher:      "raycast" | "spotlight"  (modules/darwin/launcher.nix)
          #   keyboard:      "iso" | "ansi"           (Karabiner: ISO extra-Shift key)
          windowManager ? "aerospace",
          launcher ? "raycast",
          keyboard ? "ansi",
        }:
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit
              hostname
              user
              dotfilesDir
              windowManager
              launcher
              keyboard
              ;
          };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./modules/darwin
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-backup";
                extraSpecialArgs = {
                  inherit
                    user
                    dotfilesDir
                    windowManager
                    keyboard
                    ;
                };
                users.${user} = import ./modules/home;
              };
            }
          ];
        };
    in
    {
      darwinConfigurations = {
        "MacBook-Pro-Patryk" = mkHost {
          hostname = "MacBook-Pro-Patryk";
          user = "patryk";
          windowManager = "aerospace"; # or "none"
          launcher = "raycast"; # or "spotlight"
          keyboard = "iso"; # or "ansi"
        };
      };
    };
}
