class AddDiscordUsernameToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :discord_username, :string
  end
end
