class Card < ActiveRecord::Base

  belongs_to :user
  
  before_validation :card_date_set, on: :create
  validates :review_date, :translated_text, :original_text, presence: true
  validates_associated :cards
  validate :translate_should_not_be_eql_original

  scope :actual_cards, -> { where("review_date <= ?", Time.current).order("RANDOM()") }

  def translate_should_not_be_eql_original
    errors.add(:original_text, I18n.t("errors.eql_validate_err")) if
      translated_text.downcase == original_text.downcase
  end

  def card_date_set
    self.review_date ||= 3.days.from_now
  end
  
  def eql_translation?(text)       
    original_text.downcase == text.downcase 
  end  

  def touch_review_date!
    update_column(:review_date, 3.days.from_now)
  end

end
