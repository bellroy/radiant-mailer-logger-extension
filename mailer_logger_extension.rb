gem 'mislav-will_paginate', '~> 2.2'
require 'will_paginate'

class MailerLoggerExtension < Radiant::Extension
  version "1.0"
  description "All the functionality of a Mailer that also logs the mail in the Database"
  url "http://github.com/tricycle/radiant-mailer-logger-extension/"
  
  define_routes do |map|
    map.mail_purge 'admin/mail/purge',
      :controller => 'admin/mailer_logger', 
      :action => 'purge', 
      :conditions => {:method => :delete}
    map.resources :mail, 
                  :controller => 'admin/mailer_logger',
                  :path_prefix => 'admin'
  end
  
  def activate
    require 'mailer_logging'
    require 'mailer_page'
    MailerPage.send :include, MailerLogging
    MailerPage.send :alias_method_chain, :send_mail, :log
    admin.tabs.add "Mail", "/admin/mail", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
     admin.tabs.remove "Mail"
  end
end