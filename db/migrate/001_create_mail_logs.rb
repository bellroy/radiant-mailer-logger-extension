class CreateMailLogs < ActiveRecord::Migration
  def self.up
    create_table :mail_logs do |t|
      t.string    :form_name
      t.string    :form_data
      t.boolean   :success
      t.timestamps
    end
  end

  def self.down
    drop_table :mail_logs
  end
end
