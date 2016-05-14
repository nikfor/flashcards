class TrainerController < ApplicationController

  skip_before_action :require_login

  def index
    @card = current_user.cards.actual_cards.first
  end

  def review
    card = current_user.cards.find_by(id: params[:id])
    unless card
      render_404
    else
      if card.eql_translation?(params[:expected_card][:expected_text])
        card.touch_review_date!
        redirect_to :back, alert: t("alert.right")
      else
        redirect_to :back, alert: t("alert.not_right")
      end
    end
  end

end
