{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bat
    btop
    cargo
    dig
    fzf
    gcc
    git
    htop
    inetutils
    intel-gpu-tools
    jq
    nixfmt-rfc-style
    nodejs_22
    pciutils
    (python3.withPackages (
      ps: with ps; [
        pip
        virtualenv
        setuptools-rust
        argcomplete
      ]
    ))
    rclone
    restic
    smartmontools
    tmux
    tree
    unzip
    wget
    zfs
    zip
    zoxide
  ];
}
