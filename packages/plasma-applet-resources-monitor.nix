{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  kdePackages,
}:

stdenv.mkDerivation rec {
  pname = "plasma-applet-resources-monitor";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "orblazer";
    repo = "plasma-applet-resources-monitor";
    rev = "refs/tags/v${version}";
    hash = "sha256-du38PM5kLiBWwEvli8mfUGTfMGqdS86CkMttTepMhFk=";
  };

  nativeBuildInputs = [
    cmake
    kdePackages.wrapQtAppsHook
  ];

  buildInputs = [
    kdePackages.libplasma
    kdePackages.libksysguard
    kdePackages.kdeplasma-addons
  ];

  meta = {
    description = "Resources monitor - Plasma 6 widget";
    longDescription = ''
      Plasmoid for monitoring CPU, memory, network traffic, GPUs and disks IO.
    '';
    license = lib.licenses.gpl3;
    homepage = "https://github.com/orblazer/plasma-applet-resources-monitor/";
    maintainers = with lib.maintainers; [ johnylpm ];
  };
}
