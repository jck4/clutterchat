class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  devise :database_authenticatable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: [:discord]
  
  # No need for email validation anymore
  validates :email, presence: false, allow_nil: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.discord_username = auth.info.name
      user.password = Devise.friendly_token[0, 20] # Assign a random password
    end
  end
end
