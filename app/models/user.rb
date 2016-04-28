class User < ActiveRecord::Base
  has_many :cards
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :email, presence: true
  validates :email, email_format: { message: I18n.t('user.invalid_email_message') }
  validates :email, uniqueness: { message: I18n.t('user.with_given_email_is_already_registered') }
  validates :password,
              length: { minimum: 3, message: I18n.t('user.password_has_to_be_more_than_3_char') },
              if: -> { new_record? || changes[:crypted_password] }
  validates :password,
              confirmation: { message: I18n.t('user.password_not_equal_confirmation') },
              if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation,
              presence: { message: I18n.t('user.enter_password_confirmation') },
              if: -> { new_record? || changes[:crypted_password] }
end
