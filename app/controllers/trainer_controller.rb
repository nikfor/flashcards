class TrainerController < ApplicationController

  skip_before_action :require_login

  def index
    if current_user
      unless @card = current_user.get_card
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
      if result_review[:success]
        flash[:notice] = result_review[:text]
      else
        flash[:alert] = result_review[:text]
      end
      redirect_to :back
    end
  end

  private

  def find_current_pack
    current_user.packs.current_packs.first
  end

end
