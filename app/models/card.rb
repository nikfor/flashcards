class Card < ActiveRecord::Base

  before_validation :card_date_set, on: :create
  validates :review_date, :translated_text, :original_text, presence: true
  validate :translate_not_eql_orginal

  def translate_not_eql_orginal
    errors.add(:original_text, I18n.t("errors.eql_validate_err")) if
      translated_text.downcase == original_text.downcase
  end

  def card_date_set
    self.review_date ||= 3.days.from_now
  end

  scope :actual_cards, -> { where("review_date <= ?", Time.current).order("RANDOM()").first }
  

  def eql_translation?(text)       
    original_text.downcase == text.downcase 
  end  

  def touch_review_date!
    update_column(:review_date, 3.days.from_now)
  end

end
