# nix-config

## Fresh install

1. lsblk (to find the partition name)
2. vim disk-config.nix (to change what is needed)
3. sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disk-config.nix
4. mount -t btrfs (to check if everything ok)
5. sudo nixos-generate-config --no-filesystems --root /mnt (to generate the hardware-configuration.nix file)
6. sudo cp *.nix /mnt/etc/nixos && cd /mnt/etc/nixos
7. sudo nix --experimental-features "nix-command flakes" flake lock
8. nix --experimental-features "nix-command flakes" repl
9. sudo nixos-install --root /mnt --flake "/mnt/etc/nixos#nixos"

## Check disk config

:lf .
outputs.nixosConfigurations.nixos.config.fileSystems (should return something)
