class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  devise :omniauthable, omniauth_providers: [:discord]

  # Create or find the user via Discord OAuth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.discord_username = "#{auth.info.name}"
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
