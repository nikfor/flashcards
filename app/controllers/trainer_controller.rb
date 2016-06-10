class TrainerController < ApplicationController

  skip_before_action :require_login

  def index
    if current_user.cards.empty?
      redirect_to :back, alert: t("alert.no_have_cards")
    elsif current_user.packs.empty?
      redirect_to :back, alert: t("alert.no_have_packs")
    elsif current_user.packs.current_packs.empty?
      @card = current_user.cards.actual_cards.first
      flash[:alert] = t("alert.choose_current_pack")
    elsif find_current_pack.cards.empty?
      @card = current_user.cards.actual_cards.first
      flash.now[:alert] = t("alert.current_pack_empty")
    else
      @card = find_current_pack.cards.actual_cards.first
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
