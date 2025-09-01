# lib/theater.rb

class Theater
  def show_movie(title)
    "Now showing: #{title}"
  end

  def sell_ticket(title, price)
    "Sold ticket for #{title} at $#{price}"
  end

  def open?
    true
  end
end
