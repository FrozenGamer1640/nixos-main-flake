{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation rec {
  pname = "osu-resources";
  version = "5d5020878bbdd9e54fbe89c6d2f833d17750e94c";

  src = pkgs.fetchFromGitHub {
    owner = "ppy";
    repo = "osu-resources";
    rev = version;
    sha256 = "sha256-pMBrrE8ua5CAAHL1X+dIvDCln6Ut8ZzfUgkUrnxC+6I=";
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
