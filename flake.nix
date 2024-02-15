{
  description = "My PhD experimental packages";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nur-kapack.url = "github:oar-team/nur-kapack/master";
  };

  outputs = { self, nixpkgs, nur-kapack }: 
    let
      system = "x86_64-linux";
  	  pkgs = import nixpkgs { inherit system; };
  	  kapack = nur-kapack.packages.${system};
    in {
      packages.${system} = {
        wrench = pkgs.callPackage ./pkgs/wrench {
          inherit (kapack) batsched;
          inherit (kapack) simgrid;
        };
      };
    };
}
