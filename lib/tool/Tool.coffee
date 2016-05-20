{compileFile, astwalk} = require './../helpers'
TypedClass = require '../TypedClass'

module.exports = class Tool extends TypedClass
  init : ( opts ) =>

  withFile : ( file ) =>
    ast = compileFile file
    @withAst ast

  withAst : ( ast ) =>
    throw new Error "bad ast" unless ast
    @ast = ast
    @walk = astwalk(ast, true)
    @

  run : =>
    throw new Error "virtual function called"

  @create : ( opts ) -> super opts, __dirname
    
