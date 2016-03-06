class WelcomeController < ApplicationController

  def index
    @card = Card.actual_cards
  end

end
