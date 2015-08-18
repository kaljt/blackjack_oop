class Card
  attr_reader :value

  def initialize(value, state = "face_down")
    @value = value
    @state = state
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

card = Card.new(5)
puts card.inspect
if card.respond_to?("state")
  puts "Card state is #{card.state}"
else
  puts "card doesn't understand the card_state message"
end

card.flip
if card.respond_to?("is_up?")
  if card.is_up?
    puts "I can see the card"
    puts card.inspect
  end
else
  puts "card doesn't understand the is_up? message"
end

puts "What would you like to know about the card?"
request = gets.chomp
if card.respond_to?(request)
  puts card.__send__(request)
else
  puts "no such information available"
end
