# Fancy Sprites
Fancy sprites is a very minimalistic spriting solution for your web projects based on [spritesmith](https://github.com/Ensighten/spritesmith).

It gives you the flexibility to provide sprite sheets in multiple resolutions.

Sample configuration with '1x', '2x' sprite sheets:
``` JavaScript
{
  create: {
    destStyles: 'tmp/sprites',
    destSpriteSheets: 'tmp/result/assets/sprites',
    files: [{
        src: ['app/sprites/**/*.{png,jpg,jpeg}', '!app/sprites/**/*@2x.{png,jpg,jpeg}'],
        spriteSheetName: '1x',
        spriteName: function(name) {
          return path.basename(name, path.extname(name));
        }
      }, {
        src: 'app/sprites/**/*@2x.{png,jpg,jpeg}',
        spriteSheetName: '2x',
        spriteName: function(name) {
          return path.basename(name, path.extname(name)).replace(/@2x/, '');
        }
      }
    ]
  }
}
```

The task then automatically gathers multiple versions of the same sprite based on the return value of the `spriteName` function. Here is what the generated SCSS file then looks like:

``` SCSS
$sprite-first: "1x" 416px 0px 200px 200px 1100px 925px, "2x" 816px 0px 400px 400px 2160px 1810px;
$sprite-second: "1x" 0px 416px 200px 200px 1100px 925px;

$sprites: "first" $sprite-first, "second" $sprite-second;
```

Files:
- `first.png`
- `first@2x.png`
- `second.png`

See fancy-sprites-styles for a SCSS Mixin that consumes this output.