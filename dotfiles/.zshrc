# Aliases
alias nxed="code ~/nixos-config"
alias nxrb="sudo nixos-rebuild switch --flake ~/nixos-config#royalis"
alias nxcheck="sudo nixos-rebuild test --flake ~/nixos-config#royalis"
alias nxup="nix flake update --flake ~/nixos-config"
alias nxgc="sudo nix-collect-garbage --delete-older-than 30d"