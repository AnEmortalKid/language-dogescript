{makeGrammar, rule} = require('atom-syntax-tools')

grammar =
    name: "Dogescript"
    scopeName: "source.dogescript"
    fileTypes: [ "djs" ]
    firstLineMatch: '^#!.*\\bdogescript'

    macros:
        id: /(?:[a-zA-Z$_][a-zA-Z$_\d]*)/
        whsp: /(?: |\t)+/

    patterns: [
        {
            name: "comment.line"
            begin: "shh"
            end: /\n/
        }
        {
            name: "comment.block"
            begin: /^quiet/
            end: /^loud/
        }
        {
            name: 'string.quoted.single'
            begin: /\'/
            captures:
                0:
                    name: 'punctuation.definition.string.begin'
            end: '\''
            endCaptures:
                0:
                    name: 'punctuation.definition.string.end'
            patterns: [
                {
                    match: /\\(x\h{2}|[0-2][0-7]{0,2}|3[0-6][0-7]?|37[0-7]?|[4-7][0-7]?|.)/
                    name: 'constant.character.escape'
                }
                {
                    match: /[^']*[^\n\\r'\\]$/
                    name: 'invalid.illegal.string'
                }
            ]
        }
        {
            name: 'string.quoted.double'
            begin: /\"/
            captures:
                0:
                    name: 'punctuation.definition.string.begin'
            end: '\"'
            endCaptures:
                0:
                    name: 'punctuation.definition.string.end'
            patterns: [
                {
                    match: /\\(x\h{2}|[0-2][0-7]{0,2}|3[0-6][0-7]?|37[0-7]?|[4-7][0-7]?|.)/
                    name: 'constant.character.escape'
                }
                {
                    match: /[^"]*[^\n\\r"\\]$/
                    name: 'invalid.illegal.string'
                }
            ]
        }
        {
            name: "meta.function"
            match: /(such){whsp}({id})(?:{whsp}(much){whsp}(.*))?/
            captures:
                1:
                    name: "storage.type.function"
                2:
                    name: "entity.name.function"
                3:
                    name: "storage.type.function"
                4:
                    name: "meta.function.parameters"
                    patterns:
                        [{
                            name: "variable.parameter.function"
                            match: /{id}/
                        }]
            }
            {
                name: "meta.function-call.dot"
                match: /(plz){whsp}({id}(?:\.{id})*)(?:{whsp}(with){whsp}(.*))?/
                captures:
                    1:
                        name: "keyword.control"
                    2:
                        patterns: [
                            {
                                match: /^{id}$/
                                name: "entity.name.function"
                            }
                            {
                                match: /^((?:{id}\.)+)({id})$/
                                captures:
                                    1:
                                        patterns: [
                                            match: /{id}/
                                            name: "variable.other.object"
                                        ]
                                    2:
                                        name: "entity.name.function"
                            }
                        ]
                    3:
                        name: "keyword.control"
                    4:
                        name: "meta.function.parameters"
                        patterns: [
                            include: "source.dogescript"
                        ]
            }
            {
                name: "meta.function-call.does"
                match: /({id}(?:{whsp}dose{whsp}{id})+){whsp}(with){whsp}(.*)/
                captures:
                    1:
                        patterns: [
                            match: /^((?:{id}{whsp}dose{whsp})+)({id})$/
                            captures:
                                1:
                                    patterns: [
                                        {
                                            match: /dose/
                                            name: "keyword.control"
                                        }
                                        {
                                            match: /{id}/
                                            name: "variable.other.object"
                                        }
                                    ]
                                2:
                                    name: "entity.name.function"
                            ]
                    2:
                        name: "keyword.control"
                    3:
                        name: "meta.function.parameters"
                        patterns: [
                            include: "source.dogescript"
                        ]
            }
            {
                name: "keyword.control"
                match: ///\b(?:wow|wow&|rly|but|maybe|notrly|many|many|
                               so|as|trained|new|dose|with|is|very|is)\b///
            }
            {
                name: "keyword.operator"
                match: /[+\-*/%^!?:&|]/
            }
            {
                name: "keyword.operator.words"
                match: ///\b(?:not|is|and|or|next|as|more|less|lots|few|
                               bigger|smaller|biggerish|smallerish)\b///
            }
            {
                match: /{id}(?:\.{id})+/
                captures:
                    0:
                        patterns: [
                            name: "variable.other.object"
                            match: /{id}/
                        ]
            }
            {
                match: /{id}/
            }
            {
                name: "constant.numeric.decimal"
                match: /\d+(?:\.\d+)?(?:e(?:\+|-)\d+)?/
            }
        ]

makeGrammar grammar, "CSON"
