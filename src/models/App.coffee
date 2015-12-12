# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer() # Hand {} app.get('playerHand').hit()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'all', @processPlayerEvent, @
    @get('dealerHand').on 'all', @processDealerEvent, @


  processDealerEvent: (event, hand) ->
    #console.log(event, 'dealer event processing function')
    if event is 'stand'
      @compareScores()
    else if event is 'youWin'
      @trigger 'youWinApp'

  processPlayerEvent: (event, hand) ->
    #console.log event
    if event is 'stand'
      @get('dealerHand').at(0).flip()
      @get('dealerHand').dealerPlay()
    else if event is 'youWin'
      @trigger 'youWinApp'
    else if event is 'dealerWins'
      @trigger 'dealerWinApp'
    else if event is 'blackJackWin'
      @trigger 'blackJackWinApp'

  compareScores: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()

    if playerScore > dealerScore
      @trigger 'youWinApp'
    else if playerScore is dealerScore
      @trigger 'youPushApp'
    else
      @trigger 'dealerWinsApp'

      ###
          @on 'stand', ->
      @.at(0).flip()
      @dealerPlay()
      ###


# set up a listener in the initialize for the done signal from dealPlayer
#it calls a function that gets the scored from the playerhand and dealerHand
#it alerts the winner or push

# from Hand to app -> 'youWin''dealerWins''blackjackWin''stand'
# from App to View -> 'youWin', 'dealerWins', 'youPush', 'blackjackWin'