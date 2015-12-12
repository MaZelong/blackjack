# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('dealerHand').on 'gameover', => 
      @gameOver()



  gameOver: ->
    if @get('dealerHand').scores()[0] > @get('playerHand').scores()[0]
      @get('dealerHand').trigger("Won")
      @get('playerHand').trigger("Loss")
    else
      @get('dealerHand').trigger("Loss")
      @get('playerHand').trigger("Won")
      

