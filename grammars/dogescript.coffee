{makeGrammar, rule} = require('atom-syntax-tools')

grammar =
  name: "dogescript"
  scopeName: "source.dogescript"
  fileTypes: [ "djs" ]
  firstLineMatch: '^#!.*\\bdogescript'

  macros:
    # for demonstartion purpose, how to use regexes as macros
    id: /(?!\s*:)/
    args: /(?:(?:{id},{whtesp})* *{id})?/
    en: "entity.name"
    pd: "punctuation.definition"
    ps: "punctuation.separator"
    ii: "invalid.illegal"

  patterns:
    {
        name: "comment.line.dogescript"
        begin: "ssh"
        end: /\n/
    }
    {
      name: 'string.quoted.single.dogescript'
      begin: /\'/
      captures:
        0:
          name: 'punctuation.definition.string.begin.dogescript'
      end: '\''
      endCaptures:
        0:
          name: 'punctuation.definition.string.end.dogescript'
      patterns: [
        {
          match: /\\(x\h{2}|[0-2][0-7]{0,2}|3[0-6][0-7]?|37[0-7]?|[4-7][0-7]?|.)/
          name: 'constant.character.escape.dogescript'
        }
        {
          match: /[^']*[^\n\\r'\\]$/
          name: 'invalid.illegal.string.dogescript'
        }
      ]
    }
    {
        name: "storage.type.var.dogescript"
        match: /\bvery\b/
    }
    {
        name: "keyword.operator.assignment.dogescript"
        match: /\bis\b/
    }
    {
        name: "meta.function.dogescript"
        begin: /(such)\b({id})(?:\b(much)\b(.*))/
        match:
            1:
                name: "storage.type.function.dogescript"
            2:
                name: "entity.name.function.dogescript"
            3:
                name: "storage.type.function.dogescript"
            4:
                include: "#arguments"
    }

  repository: [
      
  ]

makeGrammar grammar, "CSON"