class TrainerController < ApplicationController

  skip_before_action :require_login

  def index
    if current_user
      @card = current_user.get_card
      unless @card
        redirect_to packs_path, alert: t('alert.no_have_cards')
      end
    end
  end

  def review
    card = current_user.cards.find_by(id: params[:id])
    unless card
      render_404
    else
      result_review = ReviewCardService.new(card, params[:expected_card][:expected_text]).review
      if result_review.success?
        flash[:notice] = result_review.message
      else
        flash[:alert] = result_review.message
      end
      redirect_to :back
    end
  end

  private

  def find_current_pack
    current_user.packs.current_packs.first
  end

end
