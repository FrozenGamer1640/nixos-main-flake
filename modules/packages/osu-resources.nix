{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation {
  pname = "osu-resources";
  version = "2025.1125.0";

  src = pkgs.fetchFromGitHub {
    owner = "ppy";
    repo = "osu-resources";
    rev = "5d5020878bbdd9e54fbe89c6d2f833d17750e94c";
    sha256 = "sha256-1wryzbl6y329p05zias5pkkg9rrkg9pcjv4gd9kk1mm7zrwgh5vm=";
  };

  dontStrip = true;

  installPhase = ''
    mkdir -p $out
    cp -r osu.Game.Resources/Textures $out/
    cp -r osu.Game.Resources/Samples $out/
  '';

  meta = with lib; {
    description = "Icons and Samples from osu!resources repo";
    homepage = "https://github.com/ppy/osu-resources";
    license = licenses.cc-by-nc-40;
    maintainers = with maintainers; [ Fuyuka-nix ];
    platforms = platforms.all;
  };
}
