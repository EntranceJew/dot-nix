lib:
with lib; rec {
  # This might already exist in nixpkgs lib.
  # This is just a function to find all regular files in a directory
  regularFilesIn = p:
    builtins.foldl' (acc: x:
      acc
      ++ (
        if x.value == "regular"
        then ["${p}/${x.name}"]
        else if x.value == "directory"
        then regularFilesIn "${p}/${x.name}"
        else []
      )) [] (attrsToList (builtins.readDir p));

  nixFilesIn = p: filter (f: hasSuffix ".nix" f) (regularFilesIn p);

  importIfExists = path:
    if builtins.pathExists path
    then path
    else ./empty_attrs.nix;
}
