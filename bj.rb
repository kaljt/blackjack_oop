require 'pry'
class Card
  attr_accessor :value, :state, :face 

  def initialize(value, face = nil, state = "face_down")
    @value = value
    @state = state
    @face = face
  end

  def is_up?
    @state == "face_up"
  end

  def is_down?
    @state == "face_down"
  end

  def state
    is_up? ? "face_up" : "face_down"
  end

  def flip
    @state = is_up? ? "face_down" : "face_up"
  end

end

class Deck
  attr_accessor :data

  def initialize(num, obj_type)
    @data = []
    @d_size = num
    @object_type = obj_type
    @d_size.times {|index| @data[index] = @object_type.new(nil) }
  end

  def shuffle!
    @data.shuffle!
  end

end

class BlackJackDeck
 attr_accessor :blackjack_deck
 FACE_CARDS = ['J','Q','K','A']
 SUITS = ['HEARTS','DIAMONDS','SPADES','CLUBS'] 
 FACE = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']

  def convert_to_i
    if FACE_CARDS.include?(self)
      10
    else
    self.to_i
  end
  end

  def initialize
    i = 0
    @blackjack_deck = Deck.new(52,Card)
    @cards = SUITS.product(FACE)
    @blackjack_deck.data.each do |card|
      card.value = (@cards[i][1]).to_i
      if card.value == 0
        card.value = 10
      end
      card.face = @cards[i]
      i += 1
    end
  end

  def display_card
    @blackjack_deck
  end   

  def shuffle_deck
    @blackjack_deck.shuffle!
  end
end

game_deck = BlackJackDeck.new
if game_deck.respond_to?("display_card")
  p game_deck.display_card
else
  puts "game_deck does not respond to display_card"
end
game_deck.shuffle_deck
p game_deck
#card = Card.new(5)
#puts card.inspect
#if card.respond_to?("state")
#  puts "Card state is #{card.state}"
#else
#  puts "card doesn't understand the card_state message"
#end
#
#card.flip
#if card.respond_to?("is_up?")
#  if card.is_up?
#    puts "I can see the card"
#    puts card.inspect
#  end
#else
#  puts "card doesn't understand the is_up? message"
#end
#
#puts "What would you like to know about the card?"
#request = gets.chomp
#if card.respond_to?(request)
#  puts card.__send__(request)
#else
#  puts "no such information available"
#end
