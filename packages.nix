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
    pciutils
    python3Full
    python3Packages.argcomplete
    python3Packages.pip
    python3Packages.setuptools-rust
    python3Packages.virtualenv
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
