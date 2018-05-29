class CreateErrorsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :errors do |t|
      t.string :culprit
      t.string :title
      t.string :sentry_id
      t.string :value
      t.string :count
      t.string :project_id
      t.string :user_id
      t.string :links
    end
  end
end
