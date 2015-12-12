class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    
  hit: ->
    if not @isDealer
      if @scores()[0] < 21
        @add(@deck.pop())
        @last() 
    else
      if @scores()[0] < 17
        @add(@deck.pop())
        @last()
        @hit()
      else if @scores()[0] < 22
        @trigger('gameover')  
  
  stand: ->
      @trigger("stand")
  play: ->
    @.at(0).flip()
    @hit()
    



  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]
  
  # gameStatus: (params) ->
  #   @score().push  

  # changeStatus: (params) ->
  #   ##console.log(params)
  #   @[gameStatus] = params 

