{
  description = "Minimal self-referential flake";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "self-referential-test" ''
        echo "15f8830a-9f14-429d-b1c5-283bf4f2c9ee"
      '';
  };
}
