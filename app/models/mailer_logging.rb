module MailerLogging
  protected
  def send_mail_with_log
    log = MailLog.create!(
      :form_name => form_name,
      :form_data => form_data,
      :success => send_mail_without_log
    )
    return log.success
  end
end