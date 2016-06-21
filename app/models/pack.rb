class Pack < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  validates_associated :user
  validates :name, presence: true

  scope :current_packs, -> { where(current: true) }

  def activate!
    user.packs.update_all(current: false)
    update_attributes(current: true)
  end

end
