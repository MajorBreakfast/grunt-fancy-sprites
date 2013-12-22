module.exports = (grunt) ->
  RSVP = require 'rsvp'
  path = require 'path'
  createSpriteSheets = require('./lib/createSpriteSheets')(grunt)
  createStyleSheets = require('./lib/createStyleSheets')(grunt)

  grunt.registerMultiTask 'fancySprites', 'Create sprite sheets', ->
    done = @async()

    createSpriteSheets(@data)
    .then((sprites) =>
      createStyleSheets(@data, sprites)
    )
    .then(( -> done()), ((err) -> grunt.log.error err))