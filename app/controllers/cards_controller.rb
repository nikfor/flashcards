class CardsController < ApplicationController
  
  before_action :find_card, only: [:edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    if Card.create(card_params)
      redirect_to cards_path
    else
      render "new"
    end 
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render "edit"
    end
  end

  def destroy
      @card.destroy
      redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end

  def find_card
    @card = Card.find_by(id: params[:id])
    render_404 unless @card
  end

end
