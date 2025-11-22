{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my-config.user.sin;
in
{
  options.my-config.user.sin = {
    enable = lib.mkEnableOption "activate user sin";
  };

  config = lib.mkIf cfg.enable {
    # TODO: find and replace every instance of "YOUR-USERNAME-HERE" in this repo with your username, including this file's name
    # changing your username is very hard to do, so choose wisely
    # if you have installed NixOS with the default installer, you will have set a username there. Be sure to use the same one here
    users.users.sin = {
      isNormalUser = true;
      description = "Sinclair"; # TODO set your display name here
      extraGroups = [
        "wheel"
        (lib.mkIf config.networking.networkmanager.enable "networkmanager")
      ];
      shell = lib.mkIf config.programs.zsh.enable pkgs.zsh;

      ## TODO: either set a password with ‘passwd’ immediately after installing, or, if you understand the implications, set a hashed password below
      ## if you used the graphical installer you probably set a password from there and don't need to do this
      # initialHashedPassword = "YOUR-HASHED-PASSWORD-HERE";

      openssh.authorizedKeys.keys = [
        # TODO: add your trusted ssh keys here
        # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM///////////////NOT+A+REAL+KEY///////////// user@host"
      ]
      ## you can additionally inherit the root user's trusted keys by uncommenting this line
      # ++ config.users.users.root.openssh.authorizedKeys.keys
      ;
    };
  };
}
