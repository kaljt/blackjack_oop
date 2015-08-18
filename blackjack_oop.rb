require 'pry'

class Deck
  attr_accessor :collection_size, :collection_item
  def initialize(c_size,c_item)
    puts "Creating Deck"
    @collection_size = c_size
    @collection_item = c_item
  end

  def mixup!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

end

class BlackjackDeck < Deck
  attr_accessor :cards
  def initialize(size,type)
   @cards = [] 
   ['HEARTS','DIAMONDS','SPADES','CLUBS'].each do |suit|
    ['2','3','4','5','6','7','8','9','10','J','Q','K','A'].each do |face_value|
      @cards << PlayingCard.new(suit,face_value)
    end

   end
  end

end

class Card
  attr_accessor :front, :back

  def initialize
    puts "Creating card object..."  
    @face_down = 1
    @face_up = 0
  end
  
  def flip_over
    if @face_down == 1
        @face_up = 1
        @face_down = 0
    else
      @face_down = 1
    end
    
  end
    
  def faceup?
    @face_up == 1
  end
  
  def facedown?
    @face_down == 1
  end



end



class PlayingCard < Card
  attr_accessor :face_value, :suit
  def initialize(s,fv)
    super()
    puts "Initializing PlayingCard"
    @suit = s
    @face_value = fv
  end
  
  def display_card
    "#{face_value} of #{suit}"
    
  end

  def to_s
    display_card
  end
  
  end
  
module Hand
  
  
  def initialize
    
  
  end

end

module BlackJackHand
  def add_card(new_card)
    cards << new_card
      
  end

def show_hand
  cards.each do |card|
    card.display_card.to_s
  end
end

def total

end

end

class BlackJackPlayer
  include BlackJackHand
  attr_accessor :cards, :name
  def initialize (n)
  
    @name = n 
    @cards = []
    
  end
  
end

class BlackJackDealer
  include BlackJackHand
  attr_accessor :cards, :name
  def initialize
  @name = "DEALER"
  @cards = []
  end
end





deck = BlackjackDeck.new(52,PlayingCard)
deck.mixup!
puts deck.cards
player = BlackJackPlayer.new("Betty")
player.add_card(deck.deal_one)
p player.show_hand
p player.total

dealer = BlackJackDealer.new
dealer.show_hand
dealer.total

#card.flip_over
#puts card.faceup?
