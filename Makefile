all:	stow nix-switch
	@echo

nix-switch:
	sudo nixos-rebuild switch

upgrade:
	sudo nix-channel --update
	sudo nixos-rebuild switch --upgrade

nocache:
	sudo nixos-rebuild switch --option build-use-substitutes false

stow:
	stow -v 1 bash git emacs xmonad i3 fish haskell

stow_osx:
	stow -v 1 bash git emacs fish

# https://github.com/NixOS/nixpkgs/issues/23926
workaround:
	sudo nix-collect-garbage --delete-older-than 60d
