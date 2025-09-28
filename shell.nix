{ pkgs ? import <nixpkgs> {} }:
let
    formatAll = pkgs.writeShellScriptBin "format-project" ''
        echo "Formatting .css files ..."
        ${pkgs.biome}/bin/biome format --write *.css

        echo "Formatting .html files ..."
        ${pkgs.djlint}/bin/djlint --reformat --indent 2 *.html
    '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    biome
    djlint
    formatAll
  ];

  shellHook = ''
    export HISTFILE=.history
  '';
}