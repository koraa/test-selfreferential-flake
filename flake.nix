{
  description = "Minimal self-referential flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.self-alpha-3.url = "github:koraa/test-selfreferential-flake?ref=d02a29ed0b2771d6d96e071888f1194f6887d038";
  inputs.self-beta-3.url = "github:koraa/test-selfreferential-flake?ref=760b75a17ab6e207645a4679bb62853fc21a3a73";

  outputs = { self, nixpkgs, self-alpha-3, self-beta-3 }: rec {
    packages.x86_64-linux.alpha-3 = self-alpha-3.packages.x86_64-linux.default;
    packages.x86_64-linux.beta-3 = self-beta-3.packages.x86_64-linux.default;
    packages.x86_64-linux.gamma-3 =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "self-referential-test" ''
        echo "gamma-3 15f8830a-9f14-429d-b1c5-283bf4f2c9ee"
      '';
    packages.x86_64-linux.default = packages.x86_64-linux.gamma-3;
  };
}
