class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => 
      @render()
      @gameStatus()  
    @collection.on 'stand', =>
      @collection.off 'stand add remove change'
      
    @render()
    @gameStatus()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el

  gameStatus: ->
    if @collection.scores()[0] > 21
      @$('.score').text "BUST #{@collection.scores()[0]}" 
    
    else if @collection.scores()[0] == 21
      @$('.score').text "WIN #{@collection.scores()[0]}" 

    else 
      @$('.score').text @collection.scores()[0]



