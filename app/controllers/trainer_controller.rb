class TrainerController < ApplicationController

  def review
    card = Card.where(id: params[:id]).first
    unless card
      render_404 
    else
      if card.eql_translation?(params[:expected_card][:expected_text])
        card.touch_review_date!
        redirect_to :back, alert: t("notice.right")
      else
        redirect_to :back, alert: t("notice.not_right")
      end
    end
  end

end
