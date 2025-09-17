with import (fetchTarball("https://github.com/NixOS/nixpkgs/archive/1dab772dd4a68a7bba5d9460685547ff8e17d899.tar.gz")) { };
let 
  buildInputs = (with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        ms-vscode.cpptools
      ];
    })
  ]);
in
mkShell {
  # name = "mpi-test-shell";
  buildInputs = buildInputs;
}
