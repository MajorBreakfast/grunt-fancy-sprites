# Fancy Sprites
Fancy sprites is a very minimalistic spriting solution for your web projects based on [spritesmith](https://github.com/Ensighten/spritesmith).

It gives you the flexibility to provide sprite sheets in multiple resolutions.

[Tutorial for Fancy Sprites on YouTube](http://youtu.be/xD8DW6IQ6r0) (Note: The SCSS has changed slightly since)

Installation: `npm install --save grunt-fancy-sprites`

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

The task automatically gathers multiple versions of the same sprite based on the return value of the `spriteName` function. Here is what the generated SCSS file then looks like:

``` SCSS
$sprite-first: "first", "1x" 416px 0px 200px 200px 1100px 925px, "2x" 816px 0px 400px 400px 2160px 1810px;
$sprite-second: "second", "1x" 0px 416px 200px 200px 1100px 925px;

$sprites: $sprite-first $sprite-second;
```

Files:
- `first.png`
- `first@2x.png`
- `second.png`

See [fancy-sprites-scss](https://github.com/MajorBreakfast/fancy-sprites-scss) for a SCSS Mixin that consumes this output.

Want to provide a LESS or Stylus mixin? Send me the code for a mixin with similiar functionality and I'll implement the code that generates the sprites input like in the SCSS file above.
