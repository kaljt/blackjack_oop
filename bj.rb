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
 DECK_COUNT = 7
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
    @blackjack_deck = Deck.new(364,Card)
    @cards = SUITS.product(FACE) * DECK_COUNT
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

module Hand

  def total
    @ace_count = 0
    @hand_total = 0
     @hand.each do |card|
      @hand_total += card.value
      if card.face[1].include?("A")
        @ace_count +=1
        end
     end                                       
       @ace_count.times  do                      
         if @hand_total > 21                                        
            @hand_total -= 9
         else
            @hand_total +=1   
         end
       end
     @hand_total.to_s
  end

  def busted?
    total.to_i > 21
  end

  def place_bet
    puts "#{name} Place a bet?"
    @bet = gets.chomp.to_i
  end

  def blackjack
    @hand_total == 21
  end


end

class Dealer
  include Hand
  attr_accessor :hand
  attr_reader :name

  def initialize
    @name = "Dealer"
    @hand = []
    @hand_total = 0
    puts "\n"
  end

  def clear
    @hand = []
  end

  def show_hand
    puts "Dealer's hand =>"
    @hand.each do |card|
      puts "=> #{card.face[1]} of #{card.face[0]}"
    end
    puts "Dealer Total: " + total
  end
  def pre_flop_total
    puts "Dealer's hand =>"
    puts "=> " + @hand.first.face[1] + " of " + @hand.first.face[0] 
    puts "Dealer Total: " + @hand.first.value.to_s
  end

  def has_blackjack
    total.to_i == 21
  end

  #def total
  #   @hand.each do |card|
  #    @hand_total += card.value
  #    end
  #    @hand_total.to_s
  #end
end

class Player
  include Hand
  attr_accessor :hand
  attr_reader :name, :hand_total

  @@number_of_players = 0
  @@player_list = []

  def self.player_list
    @@player_list
  end

  def self.number_of_players
    @@number_of_players
  end

  def initialize
    @@number_of_players += 1
    @@player_list << self
    @name = "foo"
    @hand = []
    @hand_total = 0
    @bet = 0
    @cash = 100
    puts "Please enter name for player_" + @@number_of_players.to_s
    @name = gets.chomp
  end
  def clear
    @hand = []
  end
  def show_hand
    puts "#{@name}'s hand => "
    @hand.each do |card|
      puts "=> #{card.face[1]} of #{card.face[0]}"
      end
      puts "=>Total: " + total
      puts "---------"
  end

  #def total
  #  @ace_count = 0
  #  @hand_total = 0
  #   @hand.each do |card|
  #    @hand_total += card.value
  #    if card.face[1].include?("A")
  #      @ace_count +=1
  #      end
  #   end                                       
  #     @ace_count.times  do                      
  #       if @hand_total > 21                                        
  #          @hand_total -= 9
  #       else
  #          @hand_total +=1   
  #       end
  #     end
  #   @hand_total.to_s
  #end
  #def busted?
  #  total.to_i > 21
  #end
  #def place_bet
  #  puts "#{name} Place a bet?"
  #  @bet = gets.chomp.to_i
  #end
#
  #def blackjack
  #  @hand_total == 21
  #end


end


class Game
  attr_reader :game_deck
MAX_PLAYERS = 7
#@@player_list = []

  def initialize
  @game_deck = BlackJackDeck.new
  #p game_deck
  @game_deck.shuffle_deck
  #p game_deck
  end
  def start
    puts "Welcome to Blackjack!"
    puts "How many players at the table?"
    num_players = gets.chomp.to_i
    num_players.times {add_player}
    @dealer = Dealer.new
    play
  end
  def add_player
    num_players = (Player::number_of_players) + 1
    player_prepend = "player"
    player_number = player_prepend +"_"+num_players.to_s
    instance_variable_set("@#{player_number}", Player.new)
     #instance_variable_get(player_number.to_sym)

  end
  def play
      continue = " "
      while continue != 'n'
      player_bet
      player_deal
      dealer_deal
      player_deal
      display_player_hands
      @dealer.pre_flop_total
      dealer_deal
      dealer_blackjack?
      blackjack?
      hit_or_stay?
      blackjack?
      display_dealer_hand
      dealer_hit
      compare_hands

      puts "Continue play?"
      continue = gets.chomp.downcase
      clear_hand
    end
  end

  def clear_hand
    @dealer.clear 
    Player::player_list.each do |player|
      player.clear
    end
  end
  def player_bet
      Player::player_list.each do |player|
      player.place_bet
      end
  end

  def player_deal
      Player::player_list.each do |player|
      @game_deck.deal_card(player)
      end
  end

  def dealer_deal
    @game_deck.deal_card(@dealer)
  end

  def display_player_hands
    Player::player_list.each do |player|
      player.show_hand
    end
  end
  def hit_or_stay?
    choices = ['H','S']
    Player::player_list.each do |player|
        while !player.busted?  && player.total.to_i != 21
        puts "#{player.name}, would you like to (h)it or (s)tay?"
        if !choices.include?(p_choice = gets.chomp.upcase)
          puts "Error, must (h)it or (s)tay."
          next
        end
        if p_choice == 'S'
          puts "#{player.name} chose to stay with " + player.total
          break
        end
        puts "Dealing card to #{player.name}"
        game_deck.deal_card(player)
        player.show_hand

      end
      if player.busted?
        puts "#{player.name} busted with " + player.total
      end
    end
  end
  def dealer_hit
    if @dealer.total.to_i == 17
      puts "Dealer stands at #{dealer.total}"
    else
      while @dealer.total.to_i < 17
        game_deck.deal_card(dealer)
      end
    end
  end
  def display_dealer_hand
    @dealer.show_hand
  end
  def dealer_blackjack?
    @dealer.has_blackjack
  end
  def blackjack?
    Player::player_list.each do |player|
      if player.blackjack
        puts "#{player.name} hit 21!"
      end
    end
  end

end

game = Game.new
game.start

#p game_deck
#player_one = Player.new("Maverick")
#dealer = Dealer.new
#game_deck.deal_card(player_one)
#game_deck.deal_card(player_one)
#player_one.show_hand
#game_deck.deal_card(dealer)
#dealer.show_hand
#dealer.pre_flop_total
#if game_deck.respond_to?("display_card")
#  p game_deck.display_card
#else
#  puts "game_deck does not respond to display_card"
#end
#game_deck.shuffle_deck
#p game_deck
#


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
