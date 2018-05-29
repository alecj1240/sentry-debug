class CreateSentryerrors < ActiveRecord::Migration[5.1]
  def change
    create_table :sentryerrors do |t|

      t.timestamps
    end
  end
end
