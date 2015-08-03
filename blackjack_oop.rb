require 'pry'

class Deck
attr_accessor :collection_size, :collection_item
  def initialize(c_size,c_item)
    puts "Creating Deck of #{c_size} #{c_item.class}s "
    @collection_size = c_size
    @collection_item = c_item
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
def initialize(s,v)
  super()
  puts "Initializing PlayingCard"
  @suit = s
  @value = v
end

end

my_card = PlayingCard.new("HEARTS",10)
my_deck = Deck.new(52,my_card)
#card.flip_over
#puts card.faceup?
