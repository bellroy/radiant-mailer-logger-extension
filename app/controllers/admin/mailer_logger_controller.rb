include MailerLoggerHelper

class Admin::MailerLoggerController < ApplicationController
  def index
    list
  end
  
  def list
    respond_to do |format|
      format.csv do
        @mail_logs = MailLog.find(:all, :order => 'created_at DESC')
        send_data(mail_logs_to_csv(@mail_logs), :type => 'text/csv; header=present', :filename => 'mail_logs.csv')
      end
      format.html do
        @mail_logs = MailLog.paginate :page => params[:page], :order => 'created_at DESC'
        render :action => 'list'
      end
    end
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
