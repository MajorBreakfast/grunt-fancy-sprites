module.exports = (grunt) ->
  spritesmith = require 'spritesmith'
  _ = grunt.util._
  RSVP = require 'rsvp'
  path = require 'path'
  
  ###
  Creates the spritesheet file using spritesmith

  @method createSpriteSheets
  @return {Promise} Object, e.g.
    {
      'sprite1': {
        '1x': { x: 0, y: 647, width: 100, height: 31,
                spriteSheetWidth: 724, spriteSheetHeight: 678 },
        '2x': { x: 526, y: 1024, width: 200, height: 62,
                spriteSheetWidth: 1424, spriteSheetHeight: 1254 }
      },
      'sprite2': {
        '1x': { x: 712, y: 304, width: 9, height: 24,
                spriteSheetWidth: 724, spriteSheetHeight: 678 }
      }
    }
    ...
  ###
  createSpriteSheets = (data) -> new RSVP.Promise (resolve, reject) ->
    sprites = {}
    promises = []

    data.files.forEach ({src, spriteSheetName, spriteName}) ->

      inputFiles = grunt.file.expand {filter: 'isFile'}, src
      outputFile = path.join data.destSpriteSheets, (spriteSheetName + '.png')

      promise = callSpritesmithAndSaveFile(inputFiles, outputFile)
      promises.push promise

      promise.then(({coordinates, properties, engine}) ->
        grunt.log.ok "Created sprite sheet '#{spriteSheetName}' using #{engine}."

        _.forOwn coordinates, (coordinates, spriteFile) ->
          sprites[spriteName(spriteFile)] ?= {}
          sprites[spriteName(spriteFile)][spriteSheetName] =
            x: coordinates.x
            y: coordinates.y
            width: coordinates.width
            height: coordinates.height
            spriteSheetWidth: properties.width
            spriteSheetHeight: properties.height
      )

    resolve RSVP.all(promises).then( -> sprites)



  ###
  Creates the spritesheet file using spritesmith

  @method callSpritesmithAndSaveFile
  ###
  callSpritesmithAndSaveFile = (inputFiles, outputFile) ->
    new RSVP.Promise (resolve, reject) ->
      if inputFiles.length is 0 then resolve(); return

      engine = _.find ['phantomjs', 'canvas', 'gm'], (e) ->
          spritesmith.engines[e]? # First engine that matches

      spritesmith
        src: inputFiles
        algorithm: 'binary-tree'
        engine: engine
        padding: 8
      , (err, result) ->
        if err? then reject err; return

        grunt.file.write outputFile, result.image, encoding: 'binary'

        result.engine = engine
        resolve result

  return createSpriteSheets