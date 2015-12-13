class window.AppView extends Backbone.View
  className: 'play-table'
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="reset-button">Deal Another Hand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    #playerHand is a property on App that contains a Hand collection
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .reset-button': -> @model.reset()

  initialize: ->
    @model.on 'all', @filter, @
    # @model.on('blackJackWinApp', @endCondion)
    # @model.on('dealerWinApp', @endCondition
    # @model.on 'reset', @render, @
    # @model.on 'reshuffle', @endCondition, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  filter: (trigger) ->
    console.log trigger
    if trigger is 'youWinApp' or trigger is 'dealerWinApp' or trigger is 'youPushApp' or trigger is 'blackJackWinApp' or trigger is 'reshuffle'
      console.log(trigger)
      @endCondition(trigger)
    else if trigger is 'reset'
      @render()

  endCondition: (endTrigger) ->
    # always tags a div on (last element)?
    if endTrigger is 'youWinApp' then display = 'You win!!'
    if endTrigger is 'blackJackWinApp' then display = 'BlackJack! You Win!'
    if endTrigger is 'youPushApp' then display = 'You Push!'
    if endTrigger is 'dealerWinApp' then display = 'You lose!'
    if endTrigger is 'reshuffle' then display = 'Shuffling the deck!'
    # text inside varies based on trigger
    @$('.dealer-hand-container').append('<div class="win">' + '<span class="win-text">' + display + '</span>' +'</div>').fadeIn('slow')

    # from App to View -> 'youWinApp', 'dealerWinApp', 'youPushApp', 'blackJackWinApp'



    # initialize: ->
    #   @model.on 'all', @endCondition, @
    #   @render()

    # render: ->
    #   @$el.children().detach()
    #   @$el.html @template()
    #   @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    #   @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

    # endCondition: (endTrigger) ->
    #   # always tags a div on (last element)?
    #   # text inside varies based on trigger
    #   @$('.dealer-hand-container').append('<div class="Win">' + endTrigger+ '</div>')