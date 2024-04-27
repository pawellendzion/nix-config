{ pkgs }: {
  fzf-cd = pkgs.writeShellScriptBin "fzf-cd" ''
    cd "$(${pkgs.findutils}/bin/find $1 -type d 2>/dev/null | ${pkgs.fzf}/bin/fzf)"
  '';
}
