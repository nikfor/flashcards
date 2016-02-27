class Card < ActiveRecord::Base

  before_validation :card_date_set, on: :create
  validates :review_date, :translated_text, :original_text, presence: true
  validate :translate_not_eql_orginal

  def translate_not_eql_orginal
    errors.add(:original_text, I18n.t("errors.eql_validate_err")) if
      translated_text.downcase == original_text.downcase
  end

  def card_date_set
    self.review_date ||= Date.today + 3
  end

end
