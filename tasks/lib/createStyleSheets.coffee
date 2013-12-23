module.exports = (grunt) ->
  _ = grunt.util._
  path = require 'path'
  
  ###
  Creates the Json and SCSS file

  @method createStyleSheets
  ###
  createStyleSheets = (data, sprites) ->
    grunt.file.write path.join(data.destStyles, "sprites.json"), JSON.stringify(sprites)
    grunt.file.write path.join(data.destStyles, "sprites.scss"), createSCSS(sprites)


  ###
  Creates the SCSS file

  @method createSCSS
  ###
  createSCSS = (sprites) ->
    # Create a variable "$sprite-<name>: (...)" for each sprite
    variables = ''
    
    # List with all variables (("sprite" var)("sprite2" var)...)
    variable = '$sprites:'

    _.forOwn sprites, (info, name) -> # Per sprite
      variables += "$sprite-#{name}: \"#{name}\""

      _.forOwn info, (info, sheet) -> # Per appearance of a sprite in a sheet
        variables += ", \"#{sheet}\" #{info.x}px #{info.y}px "
        variables += "#{info.width}px #{info.height}px "
        variables += "#{info.spriteSheetWidth}px #{info.spriteSheetHeight}px"
        return

      variables += ";\n"
      variable += " $sprite-#{name}"
      return

    variables + '\n' + variable + ';'

  return createStyleSheets