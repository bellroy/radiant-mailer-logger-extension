require 'csv'

module MailerLoggerHelper
  def mail_logs_to_csv(mail_logs)
    output = ""
    CSV::Writer.generate(output) do |csv|
      fields = MailLog.all.collect {|x| x.form_data.keys }.flatten.uniq
      csv << ["Date", "Form"] + fields
      mail_logs.each do |mail_log|
        row = [mail_log.created_at.to_s(:db),mail_log.form_name.titlecase]
        row += mail_log.form_data.values_at(*fields)
        csv << row
      end
    end
    return output
  end
end
