class MailLog < ActiveRecord::Base
  serialize :form_data
  
  def to_s
    if form_data.include?('name')
      form_data['name']
    elsif form_data.include?('email')
      form_data['email']
    else
      id.to_s
    end
  end
  def form_data=(form_data)
    write_attribute :form_data, form_data.reject {|k,v| v.blank?}
  end
end
