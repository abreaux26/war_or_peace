require './lib/card'

class CardGenerator
  def initialize
    @cards = []
    @suits = [:heart, :diamond, :spade, :club]
    @values_ranks = {values: ['2','3','4','5','6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'],
                    ranks: [2, 3, 4, 5, 6, 7 ,8, 9, 10, 11, 12, 13, 14]}
  end

  def create_standard_deck
    @suits.each_with_index do |suit, index|
      13.times do |num|
        @cards << Card.new(suit.to_sym, @values_ranks[:values].at(num), @values_ranks[:ranks].at(num))
      end
    end
    @cards
  end
end
