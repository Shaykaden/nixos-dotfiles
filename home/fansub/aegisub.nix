{ pkgs, inputs, ...}: {
	home.packages = with pkgs; [
		aegisub
	];
}
