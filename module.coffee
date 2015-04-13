moduleKeywords = ['extended', 'included']

class Module
  @extend: (obj) ->
    for key, val of obj when key not in moduleKeywords
      @[key] = val

    obj.extended?.apply(@)
    this

  @include: (obj) ->
    for key, val of obj when key not in moduleKeywords
      @::[key] = val

    obj.included?.apply(@)
    this

module.exports = Module
