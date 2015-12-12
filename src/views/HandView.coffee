class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'
# devious if statement to make this hand view work for both dealers and players
  initialize: ->
    @collection.on 'add remove change', => @render() #a new kind of arrow! it is binding the this
    # if no fat arrow, it would probably be using the this of the collection, not handview's this
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0] ## setting the dom score to this.collection.scores() <- [hand.min(), hand.min() * 11 + hand.hasAces()]

# collection in line 15 is Hand
# every time it renders it changes the score text based on calling minscore at position 0 in the scores array in Hand
# it renders on changes