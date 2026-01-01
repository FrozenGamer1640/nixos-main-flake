fuyupkgs:
(fuyupkgs.nixpkgs.lib.genAttrs [
  "hyprlazer-desk"
  "kool-land"
] (name: import ./${name} fuyupkgs))

