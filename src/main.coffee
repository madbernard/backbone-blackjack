app = new AppView(model: new App())
app.$el.appendTo 'body'
app.model.get('playerHand').hasBlackjack()