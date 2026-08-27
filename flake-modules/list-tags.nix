{
  lib,
  self,
  ...
}: {
  perSystem = {pkgs, ...}: {
    apps.list-tags = let
      targetMetaJSON = pkgs.writeText "target-meta.json" (builtins.toJSON self.targetMeta);
    in {
      type = "app";
      program = toString (pkgs.writeShellScript "list-tags" ''
        ${lib.getExe pkgs.jq} -r '
          to_entries[] |
          "\(.key): \(.value.description) [tags: \(.value.tags | join(", "))]"
        ' ${targetMetaJSON}
      '');
    };
  };
}
