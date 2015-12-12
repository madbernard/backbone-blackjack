class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @on 'stand', -> if @isDealer then @dealerPlay
    #stop listening for hit, dealer plays until win or bust
# the array is from the hand array [card, card]; the deck is the This.deck passed through
#this.deck = deck
#this.isDealer = undefined || true
  hit: ->
    @add(@deck.pop())

  stand: -> @trigger 'stand'
  #dealer isa  hand collection that is listening for stand, if dealer
  #then it signals that it can do things...  or just does thigns

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0
# if the card is visible, add it to the score, otherwise add 0 to the score
  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 11 * @hasAce()]

  dealerPlay: -> #plays cards
    if @scores()[0] < 17 then @hit()
###

if hasace is true

[@minScore(), @minScore() + 10 * @hasAce()]  Aces are worth 11 or 1

make a stand function, which fires an event
  after stand, player hits will no longer register?
when stand called, the dealer gives themselves cards

make a bust event, for when any score goes over 21

make bust event listeners
when someone wins, pop up an alert saying who won
when dealer is done and both people have same score, alert says Push

make reset possible, after wins something makes game work again
potentially draw from same deck? and then new deck when all cards gone

aces are only displaying as 1's
if aces display 11 until over 21 then revert to 1's

make a blackjack event that fires a signal when frist two cards dealt to player are an ace and a 10
auto win
###