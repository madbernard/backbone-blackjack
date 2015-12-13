assert = chai.assert

describe 'ace handling', ->
  it 'should report correctly is a card is an ace', ->
    values = [1]
    cards = values.map (value) ->
      new Card
        rank: value % 13
        suit: Math.floor(value / 13)
    hand = new Hand (cards)
    assert.strictEqual hand.hasAce(), true

    values = [6]
    cards = values.map (value) ->
      new Card
        rank: value % 13
        suit: Math.floor(value / 13)
    hand = new Hand (cards)
    assert.strictEqual hand.hasAce(), false


  it 'should be worth 11 if possible without busting', ->
    values = [1]
    cards = values.map (value) ->
      new Card
        rank: value % 13
        suit: Math.floor(value / 13)
    hand = new Hand (cards)
    assert.strictEqual hand.scores(), 11

  it 'should not bust with two aces', ->
    values = [1, 14]
    cards = values.map (value) ->
      new Card
        rank: value % 13
        suit: Math.floor(value / 13)
    hand = new Hand (cards)
    assert.strictEqual hand.scores(), 12

  it 'should not bust with an ace and a king', ->
    values = [14, 0]
    cards = values.map (value) ->
      new Card
        rank: value % 13
        suit: Math.floor(value / 13)
    hand = new Hand (cards)
    assert.strictEqual hand.scores(), 21

  it 'should not bust with four aces', ->
    values = [1, 14, 27, 40]
    cards = values.map (value) ->
      new Card
        rank: value % 13
        suit: Math.floor(value / 13)
    hand = new Hand (cards)
    assert.strictEqual hand.scores(), 14


describe 'game play', ->

  it 'has a dealer who won\'t hit at 17', ->
    values = [7, 0]
    cards = values.map (value) ->
      new Card
        rank: value % 13
        suit: Math.floor(value / 13)
    hand = new Hand (cards)
    hand.dealerPlay()
    assert.lengthOf hand, 2

  it 'has a dealer who will hit at less than 17', ->
    deck = new Deck()
    values = [7, 2]
    cards = values.map (value) ->
      new Card
        rank: value % 13
        suit: Math.floor(value / 13)
    hand = new Hand cards, deck, true
    length1 = hand.length
    hand.dealerPlay()
    length2 = hand.length
    test = length2 > length1
    assert.strictEqual test, true

  it 'should deal cards from the deck', ->
    deck = new Deck()
    length1 = deck.length
    hand = new Hand [deck.pop(), deck.pop()], deck
    length2 = deck.length
    test = length2 < length1
    assert.strictEqual test, true
    assert.lengthOf deck, 50

  it 'should deal out two cards to each player at start', ->
    deck = new Deck()
    hand = deck.dealPlayer()
    hand2 = deck.dealDealer()
    assert.lengthOf hand, 2
    assert.lengthOf hand2, 2
    assert.lengthOf deck, 48

  xit 'should produce an informative div', ->
    app = new App()
    appView = new AppView(model: app)
    app.get('playerHand').hit()
    app.get('playerHand').hit()
    app.get('playerHand').hit()
    app.get('playerHand').hit()
    app.get('playerHand').hit()
    app.get('playerHand').hit()
    assert.strictEqual $('.win').length, 1

