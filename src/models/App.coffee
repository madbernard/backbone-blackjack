# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer() # Hand {} app.get('playerHand').hit()
    @set 'dealerHand', deck.dealDealer()
    @get('dealerHand').on 'compareScores', => @compareScores()

  compareScores: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()

    if playerScore > dealerScore
      alert 'You win!'
    else if playerScore is dealerScore
      alert 'You push!'
    else
      alert 'Dealer wins!'

# set up a listener in the initialize for the done signal from dealPlayer
#it calls a function that gets the scored from the playerhand and dealerHand
#it alerts the winner or push