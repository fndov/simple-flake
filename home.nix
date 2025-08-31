{ pkgs, ... }:{
  home-manager.users.<yourname> = {
    programs.home-manager.enable = true;
    home.stateVersion = "25.05";

    # Packages that should be installed to the user profile.
    home.packages = [
      pkgs.htop
      pkgs.git
      pkgs.cowsay
    ];

    # And so forth
  };
}
