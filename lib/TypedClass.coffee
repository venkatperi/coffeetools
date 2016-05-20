_ = require 'lodash'
path = require "path"

module.exports = class TypedClass
  constructor : ( {@type} ) ->

  @create : ( opt, dir ) ->
    opt = {} unless opt?
    throw new Error "missing option: type" unless opt.type?
    dir = __dirname unless dir?

    type = _.capitalize opt.type
    klass = require path.join dir, type
    instance = new klass opt
    instance.type = type
    instance
