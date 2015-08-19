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

  def deal_card(recipient)
    @recipient = recipient
    @recipient.hand << @blackjack_deck.data.pop
   
  end

end

class Dealer
  attr_accessor :hand
  attr_reader :name

  def initialize
    @name = "Dealer"
    @hand = []
    @hand_total = 0
  end

  def show_hand
    puts "Dealer's hand =>"
    @hand.each do |card|
      puts "=> #{card.face[1]} of #{card.face[0]}"
    end
  end
  def pre_flop_total
    puts "Dealer Total: " + @hand.first.value.to_s 
  end

  def total
     @hand.each do |card|
      @hand_total += card.value
      end
      @hand_total.to_s
  end
end

class Player
  attr_accessor :hand
  attr_reader :name

  @@number_of_players = 0

  def initialize(p_name)
    @@number_of_players += 1
    @name = p_name
    @hand = []
    @hand_total = 0
  end

  def show_hand
    puts "#{@name}'s hand => "
    @hand.each do |card|
      puts "=> #{card.face[1]} of #{card.face[0]}"
      end
      puts "=>Total: " + total
  end

  def total
     @hand.each do |card|
      @hand_total += card.value
      end
      @hand_total.to_s
  end

end



game_deck = BlackJackDeck.new
player_one = Player.new("Maverick")
dealer = Dealer.new
game_deck.deal_card(player_one)
game_deck.deal_card(player_one)
player_one.show_hand
game_deck.deal_card(dealer)
dealer.show_hand
dealer.pre_flop_total
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
