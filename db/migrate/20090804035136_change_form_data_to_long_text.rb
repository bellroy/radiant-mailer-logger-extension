class ChangeFormDataToLongText < ActiveRecord::Migration
  def self.up
    change_column :mail_logs, :form_data, :longtext
  end

  def self.down
    change_column :mail_logs, :form_data, :text
  end
end
