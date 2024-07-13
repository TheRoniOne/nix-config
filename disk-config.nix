{
  disko.devices = {
    disk = {
      my-disk = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  "/" = {
                    mountpoint = "/";
                  };
                  # Subvolume name is the same as the mountpoint
                  "/home" = {
                    mountOptions = [ "compress=zstd:1" "noatime" "ssd" "space_cache=v2" "discard=async" "commit=120" ];
                    mountpoint = "/home";
                  };
                  # Sub(sub)volume doesn't need a mountpoint as its parent is mounted
                  "/home/user" = { };
                  # Parent is not mounted so the mountpoint must be set
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" "ssd" "space_cache=v2" "discard=async" "commit=120" ];
                    mountpoint = "/nix";
                  };
                };
                mountOptions = [ "compress=zstd" "noatime" "ssd" "space_cache=v2" "discard=async" "commit=120" ];
                mountpoint = "/partition-root";
              };
            };

            swap = {
              size = "32G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
          };
        };
      };
    };
  };
}
