class Card < ActiveRecord::Base

  belongs_to :pack
  validates_associated :pack

  before_validation :card_date_set, on: :create
  validates :review_date, :translated_text, :original_text, presence: true
  validate :translate_should_not_be_eql_original

  scope :actual_cards, -> { where("review_date <= ?", Time.current).order("RANDOM()") }

  has_attached_file :avatar, styles: { medium: "360x360>" }
  validates_attachment :avatar,
    content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] }

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
