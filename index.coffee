require 'yargs'
.command require "./lib/command/tree"
.command require "./lib/command/info"
.demand 1, "Must specify a command"
.strict()
.help()
.argv
