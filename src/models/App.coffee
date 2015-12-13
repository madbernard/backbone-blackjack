# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', new Hand()
    @set 'dealerHand', new Hand()
    @dealHands()

  reset: ->
    if @get('deck').length < 13
      @trigger 'reshuffle', @
      @reshuffle()
    else
      @dealHands()
      @trigger 'reset', @

  dealHands: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('playerHand').on 'all', @processPlayerEvent, @
    @get('dealerHand').on 'all', @processDealerEvent, @
    # if @get('playerHand').hasBlackjack()
    #   console.log(@get('playerHand').hasBlackjack(), 'the entire blackJack call')
    #   @trigger 'blackJackWinApp', @
    @checkBlackjack()

  checkBlackjack: ->
    if setTimeout(@get('playerHand').hasBlackjack.bind(@get('playerHand')), 500)
      console.log('setTimeOut', @get('playerHand'))
      @trigger 'blackJackWinApp', @

  reshuffle: ->
    @set 'deck', deck = new Deck()
    @dealHands()
    @trigger 'reset', @

  processDealerEvent: (event, hand) ->
    #console.log(event, 'dealer event processing function')
    if event is 'stand'
      console.log 'dealer stood'
      @compareScores()
    else if event is 'bust'
      @trigger 'youWinApp', @

  processPlayerEvent: (event, hand) ->
    #console.log event
    if event is 'stand'
      @get('dealerHand').at(0).flip()
      @get('dealerHand').dealerPlay()
    else if event is 'bust'
      console.log 'blackJack in app'
      @trigger 'dealerWinApp', @
    # else if event is 'blackJackWin'
    #   @trigger 'blackJackWinApp', @

  compareScores: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()

    if playerScore > dealerScore
      @trigger 'youWinApp', @
    else if playerScore is dealerScore
      @trigger 'youPushApp', @
    else
      @trigger 'dealerWinApp', @

      ###
          @on 'stand', ->
      @.at(0).flip()
      @dealerPlay()
      ###


# set up a listener in the initialize for the done signal from dealPlayer
#it calls a function that gets the scored from the playerhand and dealerHand
#it alerts the winner or push

# from Hand to app -> 'bust''stand''blackJackWin'
# from App to View -> 'youWinApp', 'dealerWinApp', 'youPushApp', 'blackJackWinApp'