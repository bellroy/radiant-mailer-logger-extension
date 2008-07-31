class Admin::MailerLoggerController < ApplicationController
  def index
    @mail_logs = MailLog.find(:all, :order => 'created_at DESC')
    @mail_logs = MailLog.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def destroy
    MailLog.destroy(params[:id])
    redirect_to mail_index_path
  end
  
  def purge
    MailLog.destroy_all
    redirect_to mail_index_path
  end
end