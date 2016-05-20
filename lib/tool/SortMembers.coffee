Tool = require './Tool'
{asTree} = require './../helpers'

class SortMembers extends Tool

  init : ( opts ) =>
    @withFile opts.file if opts.file?

  run : =>
    h = process @ast
    console.log asTree h.toObject()

module.exports = SortMembers

