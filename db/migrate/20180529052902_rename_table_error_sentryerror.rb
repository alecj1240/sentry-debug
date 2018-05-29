class RenameTableErrorSentryerror < ActiveRecord::Migration[5.1]
  def change
    rename_table :errors, :sentryerrors
  end
end
