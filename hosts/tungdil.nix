{ config, lib, pkgs, ... }:

{
  imports = [
    ../users/root
    ../users/luc
    ../modules/xserver
    ../modules/nix
    ../modules/network
    ../modules/locale
    ../modules/sound
    ../modules/printing
    ../modules/common-env
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest_hardened;
    kernel.sysctl = {
      "kernel.unprivileged_userns_clone" = 1;
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" "thunderbolt" ];
    blacklistedKernelModules = [ "nouveau" ];
    extraModulePackages = [ ];
    cleanTmpDir = true;
  };
  hardware.enableRedistributableFirmware = true;

  nix.maxJobs = lib.mkDefault 12;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  systemd.extraConfig = ''
    DefaultTimeoutStopSec = 10s
  '';

  # Graphic card
  services.xserver.videoDrivers = [ "intel" ];
  hardware.nvidiaOptimus.disable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  hardware.acpilight.enable = true;

  # RGB driver for keyboard
  hardware.ckb-next.enable = true;

  # Filesystems
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1be3caa1-f5df-4e19-831e-9add0f8fed1b";
      fsType = "ext4";
    };

    "/data" = {
      device = "/dev/disk/by-uuid/f9dcf866-2a61-4823-826f-e27250197f9f";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/9366-2848";
      fsType = "vfat";
    };
  };
}
