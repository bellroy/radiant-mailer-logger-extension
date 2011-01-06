ActionController::Routing::Routes.draw do |map|
  # map.namespace :admin, :member => { :remove => :get } do |admin|
  #   admin.resources :mailer_logger
  # end

  map.with_options(:controller => 'admin/mailer_logger') do |logs|
    logs.unsent_mail 'admin/mail/unsent', :action => 'unsent'
    logs.sent_mail 'admin/mail/sent', :action => 'sent'
  end

  map.mail_purge 'admin/mail/purge',
    :controller => 'admin/mailer_logger', 
    :action => 'purge', 
    :conditions => {:method => :delete}

  map.resources :mail, 
    :controller => 'admin/mailer_logger',
    :path_prefix => 'admin'

end
