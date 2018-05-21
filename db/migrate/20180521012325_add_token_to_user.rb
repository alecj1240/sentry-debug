class AddTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sentry_token, :string
  end
end
