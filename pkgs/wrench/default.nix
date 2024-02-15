{ stdenv, batsched, simgrid, fetchgit, cmake, nlohmann_json, cppzmq }:

stdenv.mkDerivation rec {
  pname = "wrench";
  version = "2.2";

  src = fetchgit {
    url = "https://github.com/wrench-project/wrench";
    rev = "v${version}";
    sha256 = "sha256-OJ1qUY6E0xp9CZ23ec876zMaPxZ2lWuMtKztK3MBPNU=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    nlohmann_json
    cppzmq
    batsched
    simgrid
  ];

  configurePhase = ''
    mkdir build
    cd build
    cmake -DENABLE_BATSCHED=on -DCMAKE_INSTALL_PREFIX=$out/ ..
  '';

  buildPhase = ''
    make -j $NIX_BUILD_CORES
  '';

  installPhase = ''
    make install
  '';
}
