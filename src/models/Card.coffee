class window.Card extends Backbone.Model
  initialize: (params) ->
    @set
      revealed: true
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['Spades', 'Diamonds', 'Clubs', 'Hearts'][params.suit]
      rankName: switch params.rank
        when 0 then 'King'
        when 1 then 'Ace'
        when 11 then 'Jack'
        when 12 then 'Queen'
        else params.rank

  flip: ->
    @set 'revealed', !@get 'revealed'
    @

###
    Card.prototype.initialize = function(params) {
      return this.set({
        revealed: true,
        value: !params.rank || 10 < params.rank ? 10 : params.rank,
        suitName: ['Spades', 'Diamonds', 'Clubs', 'Hearts'][params.suit],
        rankName: (function() {
          switch (params.rank) {
            case 0:
              return 'King';
            case 1:
              return 'Ace';
            case 11:
              return 'Jack';
            case 12:
              return 'Queen';
            default:
              return params.rank;
          }
        })()
      });
    };

    Card.prototype.flip = function() {
      this.set('revealed', !this.get('revealed'));
      return this;
    };

    ###