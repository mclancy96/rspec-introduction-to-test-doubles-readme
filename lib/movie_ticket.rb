# lib/movie_ticket.rb

class MovieTicket
  attr_reader :title, :price

  def initialize(title, price)
    @title = title
    @price = price
  end

  def print
    "Ticket for #{@title}: $#{@price}"
  end
end
