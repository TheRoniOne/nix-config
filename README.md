# nix-config

## Fresh install
1. lsblk (to find the partition name)
2. vim disk-config.nix (to change what is needed)
3. sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /home/nixos/nix-config/disk-config.nix
4. mount -t btrfs (to check if everything ok)
5. sudo nixos-generate-config --root /mnt && cp /mnt/etc/nixos/hardware-configuration.nix . (to generate the hardware-configuration.nix file)
6. sudo nix --experimental-features "nix-command flakes" flake lock
7. sudo nixos-install --root /mnt --flake "/home/nixos/nix-config#nixos"
