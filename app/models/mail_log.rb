class MailLog < ActiveRecord::Base
  serialize :form_data
  
  validates_presence_of :form_name
  validates_presence_of :success
  validates_presence_of :form_data
  
  def self.sent_count 
    count :conditions => {:success => true}
  end
  def self.unsent_count
    count :conditions => {:success => false}
  end
  
  def sent?
    success?
  end
  
  def unsent?
    !success?
  end
  
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
    self[:form_data] = form_data.reject {|k,v| v.blank?}
  end
end
