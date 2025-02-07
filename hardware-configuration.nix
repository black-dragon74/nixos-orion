# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/212b86a4-1ed5-4966-b620-eeb9111ed75a";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C648-903B";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/01034930-d0fc-49ff-9207-c3c78cca7964"; }
  ];

  # ZFS Zvols
  fileSystems."/mnt/nextcloud" = {
    device = "/dev/disk/by-uuid/43e207ef-a1c4-403c-8ddb-8489332e3b7d";
    fsType = "xfs";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/7b3b45d3-5339-4086-8370-3064c9f07e3f";
    fsType = "xfs";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/immich" = {
    device = "/dev/disk/by-uuid/01cd2b1d-9a75-4738-9634-2c389d7fe289";
    fsType = "xfs";
    options = [ "nofail" ];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
