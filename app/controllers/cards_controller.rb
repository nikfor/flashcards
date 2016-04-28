class CardsController < ApplicationController

  before_action :find_card, only: [:edit, :update, :destroy]

  def index
    @cards = current_user.cards
  end

  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      redirect_to cards_path, :alert => t('card.success_create')
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path, :alert => t('card.success_update')
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path, :alert => t('card.success_destroy')
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end

  def find_card
    @card = current_user.cards.find_by(id: params[:id])
    render_404 unless @card
  end

end
