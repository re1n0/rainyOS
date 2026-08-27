{lib}: system: targetMeta:
lib.filterAttrs
(_name: meta: let platforms = meta.platforms or []; in platforms == [] || lib.elem system platforms)
targetMeta
