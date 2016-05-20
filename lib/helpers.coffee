fs = require 'fs'
stringify = require 'json-stringify-safe'
coffeeScript = require 'coffee-script'
treeify = require 'treeify'

log = ( s ) -> console.log stringify s, null, 2
readFile = ( f ) -> fs.readFileSync f, 'utf8'
nodes = ( src ) -> coffeeScript.nodes src
compileFile = ( file ) -> nodes readFile file
asTree = ( obj ) -> treeify.asTree obj, true

module.exports =
  readFile : readFile
  log : log
  nodes : nodes
  compileFile : compileFile
  asTree : asTree
  coffeeScript : coffeeScript
  astwalk : require '../../coffee-ast-walk/index'
