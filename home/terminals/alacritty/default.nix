{
	programs = {
	  alacritty = {
		  enable = true;
		};
	};

	home.file = {
		".config/alacritty" = {
			source = ./conf;
			recursive = true;
		};
	};
}
