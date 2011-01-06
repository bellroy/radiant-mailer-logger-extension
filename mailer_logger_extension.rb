class MailerLoggerExtension < Radiant::Extension
  version "1.0"
  description "All the functionality of a Mailer that also logs the mail in the Database"
  url "http://github.com/tricycle/radiant-mailer-logger-extension/"
  
  extension_config do |config|
    config.gem 'mislav-will_paginate', :version => '~> 2.2', :lib => 'will_paginate'
    config.gem 'haml', '~> 3.0.25'

    # config.after_initialize do
    #   run_something
    # end
  end
  
  def activate
    require 'mailer_logging'
    require 'mailer_page'
    MailerPage.send :include, MailerLogging
    MailerPage.send :alias_method_chain, :send_mail, :log

    tab "Content" do
      add_item "Mail", "/admin/mail", :visibility => [:all]
    end
  end
end
