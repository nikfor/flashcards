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
      if card.eql_translation?(params[:expected_card][:expected_text])
        card.touch_review_date!
        redirect_to :back
        flash[:notice] = t("alert.right")
      else
        redirect_to :back
        flash[:notice] = t("alert.not_right")
      end
    end
  end

  private

  def find_current_pack
    current_user.packs.current_packs.first
  end

end
