{
  description = "Minimal self-referential flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.self-alpha.url = "github:koraa/test-selfreferential-flake?ref=1033f0104e32fef7e41a92bcc49c4a8eaf03f8b5";
  inputs.self-beta.url = "github:koraa/test-selfreferential-flake?ref=7136186349d76b5de2bb01f546e917c4c3787593";

  outputs = { self, nixpkgs, self-alpha, self-beta }: {
    packages.x86_64-linux.alpha = self-alpha.packages.x86_64-linux.default;
    packages.x86_64-linux.beta = self-beta.packages.x86_64-linux.default;
    packages.x86_64-linux.default =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "self-referential-test" ''
        echo "gamma 15f8830a-9f14-429d-b1c5-283bf4f2c9ee"
      '';
  };
}
