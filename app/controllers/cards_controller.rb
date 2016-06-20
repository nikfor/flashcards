class CardsController < ApplicationController

  before_action :find_card, only: [:edit, :update, :destroy]
  before_action :find_pack

  def index
    @cards = @pack.cards
    flash.now[:alert] = t('pack.empty') if @cards.empty?
  end

  def new
    @card = @pack.cards.new
  end

  def create
    @card = @pack.cards.new(card_params)
    if @card.save
      redirect_to pack_cards_path, alert: t('card.success_create')
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to pack_cards_path, alert: t('card.success_update')
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to pack_cards_path, alert: t('card.success_destroy')
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :avatar)
  end

  def find_pack
    @pack = current_user.packs.find_by(id: params[:pack_id])
  end

  def find_card
    @card = find_pack.cards.find_by(id: params[:id])
    render_404 unless @card
  end

end
