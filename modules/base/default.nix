{ mylib, ... }: {
  imports = mylib.getPaths ./.;
}
