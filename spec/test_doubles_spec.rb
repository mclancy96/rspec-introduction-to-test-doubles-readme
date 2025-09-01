
require_relative '../lib/movie_ticket'
require_relative '../lib/theater'

RSpec.describe 'MovieTicket and Theater Test Doubles' do
  it 'uses a double for MovieTicket' do
    ticket = double('MovieTicket', title: 'Inception', price: 12.5)
    expect(ticket.title).to eq('Inception')
    expect(ticket.price).to eq(12.5)
  end

  it 'stubs a method on a Theater double' do
    theater = double('Theater')
    allow(theater).to receive(:show_movie).and_return('Now showing: Inception')
    expect(theater.show_movie('Inception')).to eq('Now showing: Inception')
  end

  it 'sets multiple stubbed methods on a double' do
    ticket = double('MovieTicket', title: 'Interstellar', price: 10, print: 'Ticket for Interstellar: $10')
    expect(ticket.print).to eq('Ticket for Interstellar: $10')
  end

  it 'uses allow(...).to receive to stub a method after creation' do
    theater = double('Theater')
    allow(theater).to receive(:open?).and_return(true)
    expect(theater.open?).to eq(true)
  end

  it 'raises error if calling unstubbed method' do
    ticket = double('MovieTicket')
    expect { ticket.price }.to raise_error(RSpec::Mocks::MockExpectationError)
  end

  it 'uses a double as a dependency in a class' do
    theater = double('Theater', sell_ticket: 'Sold ticket for Inception at $12.5')
    expect(theater.sell_ticket('Inception', 12.5)).to eq('Sold ticket for Inception at $12.5')
  end

  it 'changes what a double returns at runtime' do
    ticket = double('MovieTicket')
    allow(ticket).to receive(:title).and_return('Dune')
    expect(ticket.title).to eq('Dune')
    allow(ticket).to receive(:title).and_return('Arrival')
    expect(ticket.title).to eq('Arrival')
  end

  it 'uses a double with multiple stubbed methods and tests their return values' do
    theater = double('Theater', open?: false, show_movie: 'Now showing: Matrix')
    expect(theater.open?).to eq(false)
    expect(theater.show_movie('Matrix')).to eq('Now showing: Matrix')
  end

  it 'uses a double for a method that does not exist on the real object' do
    ticket = double('MovieTicket', popcorn: 'Yum!')
    expect(ticket.popcorn).to eq('Yum!')
  end

  it 'has a pending spec for students: double for Theater#close' do
    pending('Create a double for Theater and stub a close method that returns "Theater closed"')
    raise 'Not implemented'
    # theater = double('Theater', close: 'Theater closed')
    # expect(theater.close).to eq('Theater closed')
  end

  it 'has a pending spec for students: double for MovieTicket#refund' do
    pending('Create a double for MovieTicket and stub a refund method that returns "Refunded $10"')
    raise 'Not implemented'
    # ticket = double('MovieTicket', refund: 'Refunded $10')
    # expect(ticket.refund).to eq('Refunded $10')
  end
end
