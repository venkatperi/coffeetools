Tool = require '../tool'

module.exports = ( exp, opts ) ->

  for i in [ 'command', 'describe', 'builder' ]
    exp[ i ] = opts[ i ]

  exp.handler = ( argv ) ->
    Tool.create opts
    .init argv
    .run()


