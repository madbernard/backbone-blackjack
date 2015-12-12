class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

###
dealPlayer passes an array of two popped cards, and it passes the This that is Deck

var array = [];
for (var i = 0; i < 52; i++) {
  array.push(i);
}

array.shuffle();

return array.map(function(card) {
  new Card ({rank: card % 13, suit: Math.floor(card / 13)})
});

###