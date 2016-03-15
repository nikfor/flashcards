class CardsController < ApplicationController
  
  before_action :find_card, only: [:edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.create(card_params)
    if @card.valid?
      redirect_to cards_path
    else
      render "new"
    end 
  end

  def edit
  end

  def update
    @card.update(card_params)
    if @card.valid?
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
    @card = Card.where(id: params[:id]).first
    render_404 unless @card
  end

end
