class Pack < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  validates_associated :user
  validates :name, presence: true

  scope :current_packs, -> { where("current = ?", true) }

end
