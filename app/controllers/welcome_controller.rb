class WelcomeController < ApplicationController

  def index
    @card = Card.actual_cards.first
  end

end
