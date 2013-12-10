max_chars = 560

jQuery ->
  # Note that this should probably be switched over to an Angular type app, but for now, screw it.
  getCounterElem = ($textarea) ->
    counterElem = $textarea.next('.char-counter')
    return $(counterElem) unless counterElem.length == 0
    counterElem = $('<div class="char-counter"></div>')
    $textarea.after counterElem
    counterElem

  displayCharsLeft = ($textarea, charsLeft) ->
    counterElem = getCounterElem $textarea
    counterElem.html charsLeft

  attachCounter = ($textarea, maxCount) ->
    displayCharsLeft $textarea, maxCount
    $textarea.on 'keyup', ->
      charsUsed = $textarea.val().length
      charsLeft = maxCount - charsUsed
      displayCharsLeft $textarea, charsLeft


  attachCounter $('#entry_yesterday'), max_chars
  attachCounter $('#entry_today'), max_chars
  attachCounter $('#entry_block'), max_chars

