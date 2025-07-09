{
  description = "Minimal self-referential flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.self-main-branch.url = "github:koraa/test-selfreferential-flake";

  outputs = { self, nixpkgs, self-main-branch }: {
    packages.x86_64-linux.main-branch = self-main-branch.packages.x86_64-linux.default;
    packages.x86_64-linux.default =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "self-referential-test" ''
        echo "NEW 15f8830a-9f14-429d-b1c5-283bf4f2c9ee"
      '';
  };
}
