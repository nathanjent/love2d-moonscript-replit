{ pkgs }: {
	deps = with pkgs; [
		love
    lua53Packages.moonscript
	];
}