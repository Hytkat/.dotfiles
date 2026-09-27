{ self, inputs, ... }:
{
  flake.nixosModules.matugen =
    { pkgs, lib, ... }:
    # let
    #     # Building the latest matugen 4.1.0 for --opacity flag.
    #     matugen = pkgs.matugen.overrideAttrs (old: {
    #       version = "4.1.0";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "InioX";
    #         repo = "matugen";
    #         rev = "v4.1.0";
    #         hash = "sha256-xzwMDWb6pF3oStVoS8enNhpYptxdnB1NSIO7dUH6/qk=";
    #       };
    #       cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
    #         inherit (old) pname;
    #         version = "4.1.0";
    #         src = pkgs.fetchFromGitHub {
    #           owner = "InioX";
    #           repo = "matugen";
    #           rev = "v4.1.0";
    #           hash = "sha256-xzwMDWb6pF3oStVoS8enNhpYptxdnB1NSIO7dUH6/qk=";
    #         };
    #         hash = "sha256-bfvlPiTlPQeedo+ikHXSI8NqdA5R5M7gCsgx7srYsMQ=";
    #       };
    #     });
    # in
    {
      environment.systemPackages = [ inputs.matugen.packages."x86_64-linux".default ];

      home-manager.users.${self.user}.imports = [
        {
          # home.activation.matugen = "${inputs.matugen.packages."x86_64-linux".default}/bin/matugen image ${self.wallpaper} --opacity 0.85 --source-color-index 0";

          home.packages = with pkgs; [
            kdePackages.breeze
            kdePackages.qt6ct
            killall
            libsForQt5.qt5ct
          ];

          xdg.configFile = {
              "kdeglobals".text = ''
              [UiSettings]
              ColorScheme=Matugen
            '';
            "Kvantum/kvantum.kvconfig".text = ''
              [General]
              theme=matugen
            '';
          };

          qt = {
            enable = true;
            platformTheme.name = lib.mkForce "qt6ct";
            style.name = lib.mkForce "kvantum";

            qt5ctSettings = {
              Appearance = {
                color_scheme_path = "/home/${self.user}/.config/qt5ct/colors/matugen.conf";
                custom_palette = true;
              };
            };

            qt6ctSettings = {
              Appearance = {
                color_scheme_path = "/home/${self.user}/.config/qt5ct/colors/matugen.conf";
                custom_palette = true;
              };
            };
          };

          gtk = {
            enable = true;
            gtk4.extraCss = "@import 'colors.css';";
            gtk3.extraCss = "@import 'colors.css';";
          };
        }
      ];
    };
}
