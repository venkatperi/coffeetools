Tool = require './Tool'
{asTree} = require './../helpers'

class Base
  constructor : ( @node ) ->
    @meta = @node.meta
    @data = {}
    @data.id = @node.__id
    @data.type = @meta.type
    @init()

  init : ->

  toObject : -> @data

class Class extends Base
  init : =>
    @data.name = @meta.name
    @data.superClass = @meta.superClass if @meta.superClass?
    @data.members = []
    members = @meta.classMembers
    for own type,list of members
      for m in list
        isMethod = m.meta.isMethod
        info =
          name : m.meta.name
          membership : type
          visibility : m.meta.visibility
          memberType : if isMethod then 'method' else 'variable'

        if isMethod and m.meta.value.meta.methodParams?.length > 0
          info.params = for p in m.meta.value.meta.methodParams
            p.meta.name

        @data.members.push info
    delete @data.members if @data.members.length is 0

class Comment extends Base
  init : =>
    c = @node.comment
    if typeof c is 'string'
      c = c.replace /[\n\r]/g, '\\n'
    @data.comment = c

class Value extends Base
  init : => @data.value = @meta.value

class Block extends Base
  init : =>
    super()
    @children = []
    for e in @node.expressions ? []
      x = process e
      @children.push x if x

  toObject : ->
    @data.children = (c.data for c in @children)

process = ( node ) ->
  item = node.meta.logicalItem
  handler = handlers[ item.meta.type ]
  return unless handler
  new handler(item)

handlers =
  Block : Block
  Class : Class
  Comment : Comment
  Value : Value

class Info extends Tool

  init : ( opts ) =>
    @withFile opts.file if opts.file?

  run : =>
    h = process @ast
    console.log asTree h.toObject()

module.exports = Info

