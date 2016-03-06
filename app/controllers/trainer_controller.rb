class TrainerController < ApplicationController

  def review
    card = Card.find(params[:id])
    if card.eql_translation?(params[:expected_card][:expected_text])
      card.touch_review_date!
      redirect_to :back, alert: t("notice.right")
    else
      redirect_to :back, alert: t("notice.not_right")
    end
  end

end
#{controller: 'trainer', action: 'review', id: @card}
