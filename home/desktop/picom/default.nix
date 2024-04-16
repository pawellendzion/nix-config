{ pkgs, ... }: {
  xsession.initExtra = ''
    ${pkgs.picom}/bin/picom --config ${./conf/picom.conf} -b
  '';
}
