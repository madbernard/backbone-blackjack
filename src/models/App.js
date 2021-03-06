// Generated by CoffeeScript 1.10.0
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

window.App = (function(superClass) {
  extend(App, superClass);

  function App() {
    return App.__super__.constructor.apply(this, arguments);
  }

  App.prototype.initialize = function() {
    var deck;
    this.set('deck', deck = new Deck());
    this.set('playerHand', new Hand());
    this.set('dealerHand', new Hand());
    return this.dealHands();
  };

  App.prototype.reset = function() {
    if (this.get('deck').length < 13) {
      this.trigger('reshuffle', this);
      return this.reshuffle();
    } else {
      this.dealHands();
      return this.trigger('reset', this);
    }
  };

  App.prototype.dealHands = function() {
    this.set('playerHand', this.get('deck').dealPlayer());
    this.set('dealerHand', this.get('deck').dealDealer());
    this.get('playerHand').on('all', this.processPlayerEvent, this);
    this.get('dealerHand').on('all', this.processDealerEvent, this);
    return this.get('playerHand').hasBlackjack();
  };

  App.prototype.checkBlackjack = function() {
    if (this.get('playerHand').hasBlackjack()) {
      return this.trigger('blackJackWinApp', this);
    }
  };

  App.prototype.reshuffle = function() {
    var deck;
    this.set('deck', deck = new Deck());
    return this.dealHands();
  };

  App.prototype.processDealerEvent = function(event, hand) {
    if (event === 'stand') {
      console.log('dealer stood');
      return this.compareScores();
    } else if (event === 'bust') {
      return this.trigger('youWinApp', this);
    }
  };

  App.prototype.processPlayerEvent = function(event, hand) {
    if (event === 'stand') {
      this.get('dealerHand').at(0).flip();
      return this.get('dealerHand').dealerPlay();
    } else if (event === 'bust') {
      return this.trigger('dealerWinApp', this);
    } else if (event === 'blackJackWin') {
      console.log('blackJack in app');
      return this.trigger('blackJackWinApp', this);
    }
  };

  App.prototype.compareScores = function() {
    var dealerScore, playerScore;
    playerScore = this.get('playerHand').scores();
    dealerScore = this.get('dealerHand').scores();
    if (playerScore > dealerScore) {
      return this.trigger('youWinApp', this);
    } else if (playerScore === dealerScore) {
      return this.trigger('youPushApp', this);
    } else {
      return this.trigger('dealerWinApp', this);

      /*
          @on 'stand', ->
      @.at(0).flip()
      @dealerPlay()
       */
    }
  };

  return App;

})(Backbone.Model);
