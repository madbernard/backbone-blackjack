class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    #playerHand is a property on App that contains a Hand collection
    'click .stand-button': -> @model.get('dealerHand').stand()
    'youWin': =>
      console.log 'youWin listener initialized'
      @endCondition 'youWin'
    'dealerWins': -> console.log 'dealerWins listener initialized'
    'youPush': -> console.log 'youPush listener initialized'
    'blackJackWin': -> console.log 'blackJackWin listener initialized'

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  endCondition: (endTrigger) ->
    if endTrigger is 'youWin'
      console.log 'youWin trigger made it to endCondition'
      alert 'You win!'