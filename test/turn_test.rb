require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class TurnTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @card9 = Card.new(:diamond, '8', 8)

    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @deck3 = Deck.new([@card4, @card3, @card6, @card7])
    @deck4 = Deck.new([@card4, @card3, @card9, @card7])

    @player1 = Player.new("Clarisa", @deck1)
    @player2 = Player.new("Angel", @deck2)
    @player3 = Player.new("Aurora", @deck3)
    @player4 = Player.new("Megan", @deck4)

    @turn1 = Turn.new(@player1, @player2)
    @turn2 = Turn.new(@player1, @player3)
    @turn3 = Turn.new(@player1, @player4)
  end

  def test_it_exists
    assert_instance_of Turn, @turn1
    assert_instance_of Turn, @turn2
    assert_instance_of Turn, @turn3
  end

  def test_it_has_readable_attributes
    assert_equal @player1, @turn1.player1
    assert_equal @player2, @turn1.player2
    assert_equal [], @turn1.spoils_of_war

    assert_equal @player1, @turn2.player1
    assert_equal @player3, @turn2.player2
    assert_equal [], @turn2.spoils_of_war

    assert_equal @player1, @turn3.player1
    assert_equal @player4, @turn3.player2
    assert_equal [], @turn3.spoils_of_war
  end

  def test_type
    assert_equal :basic, @turn1.type
    assert_equal :war, @turn2.type
    assert_equal :mutually_assured_destruction, @turn3.type
  end

  def test_winner
    assert_equal @player1, @turn1.winner
    assert_equal @player3, @turn2.winner
    assert_equal "No Winner", @turn3.winner
  end

  def test_turn1_pile_cards
    @turn1.pile_cards
    assert_equal [@card1, @card3], @turn1.spoils_of_war
  end

  def test_turn2_pile_cards
    @turn2.pile_cards
    assert_equal [@card1, @card2, @card5, @card4, @card3, @card6], @turn2.spoils_of_war
  end

  def test_turn3_pile_cards
    @turn3.pile_cards
    assert_equal [], @turn3.spoils_of_war
  end

  def test_turn1_award_spoils
    winner = @turn1.winner
    @turn1.pile_cards
    @turn1.award_spoils(winner)
    assert_equal [@card2, @card5, @card8, @card1, @card3], @player1.deck.cards
    assert_equal [@card4, @card6, @card7], @player2.deck.cards
  end

  def test_turn2_award_spoils
    winner = @turn2.winner
    @turn2.pile_cards
    @turn2.award_spoils(winner)
    assert_equal [@card8], @player1.deck.cards
    assert_equal [@card7, @card1, @card2, @card5, @card4, @card3, @card6], @player3.deck.cards
  end

  def test_turn3_award_spoils
    winner = @turn3.winner
    @turn3.pile_cards
    @turn3.award_spoils(winner)
    assert_equal [@card1, @card2, @card5, @card8], @player1.deck.cards
    assert_equal [@card4, @card3, @card9, @card7], @player4.deck.cards
  end
end
