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
    this.set('playerHand', deck.dealPlayer());
    this.set('dealerHand', deck.dealDealer());
    return this.get('dealerHand').on('compareScores', (function(_this) {
      return function() {
        return _this.compareScores();
      };
    })(this));
  };

  App.prototype.compareScores = function() {
    var dealerScore, playerScore;
    playerScore = this.get('playerHand').scores();
    dealerScore = this.get('dealerHand').scores();
    if (playerScore > dealerScore) {
      return alert('You win!');
    } else if (playerScore === dealerScore) {
      return alert('You push!');
    } else {
      return alert('Dealer wins!');
    }
  };

  return App;

})(Backbone.Model);
