class window.CardView extends Backbone.View
  className: 'card' #$('.card') div is class of card

  template: _.template '<% if(this.model.get(\'revealed\')) { %><img src="img/cards/<%= rankName %>-<%= suitName %>.png" alt="<%= rankName %> of <%= suitName %>"><% }else{ %><img src="img/card-back.png" alt="Card Back"><% }%></img>' #7 of Hearts
  #<img src=7 of hearts</img>
  # <img src="" alt="">  </img>
  #template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'



  initialize: -> @render()

  render: ->
    @$el.children().detach() #we don't know what this is about, why detach
    @$el.html @template @model.attributes # this.$el.html(this.template(this.model.attributes))
    @$el.addClass 'covered' unless @model.get 'revealed'


