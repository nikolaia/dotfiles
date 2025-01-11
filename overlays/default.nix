[
  (final: prev: {
    csharp-ls = prev.csharp-ls.overrideAttrs (old: {
      meta = old.meta // {
        platforms = prev.lib.platforms.all;
        badPlatforms = [ ];
      };
    });
  })
]

