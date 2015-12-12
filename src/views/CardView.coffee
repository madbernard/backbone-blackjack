class window.CardView extends Backbone.View
  className: 'card' #$('.card')

  template: _.template '<%= rankName %> of <%= suitName %>' #7 of Hearts

  initialize: -> @render()

  render: ->
    @$el.children().detach() #we don't know what this is about, why detach
    @$el.html @template @model.attributes # this.$el.html(this.template(this.model.attributes))
    @$el.addClass 'covered' unless @model.get 'revealed'


