class Card < ActiveRecord::Base
  #attr_accessible :original_text, :translated_text, :review_date
  validates :original_text, :translated_text, presence: true
end
