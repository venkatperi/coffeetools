Tool = require './Tool'
{asTree} = require '../helpers'

module.exports = class Tree extends Tool

  init : ( opts ) =>
    @withFile opts.file if opts.file?

  run : =>
    res = @walk.walk ( x ) ->
      o = {}
      return o if @id in [ 'locationData' ]
      type = x.__type

      @id = "#{@id} {#{type}}" if type? and @id?
      @id = "{#{type}}" unless @id?
      @id += " ##{x.__id}" if x.__id?

      if type?
        switch type
          when 'Literal'
            o.value = x.meta?.value if x.meta?.value?
      else
        # cleanup multiline strings
        if typeof x is 'string'
          x = x.replace /[\n\r]/g, '\\n'
        o = "'#{x}' {#{typeof x}}"
      o

    console.log asTree res

