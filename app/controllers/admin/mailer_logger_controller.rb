class Admin::MailerLoggerController < ApplicationController
  def index
    list
    render :action => 'list'
  end
  
  def list(*conditions)
    @mail_logs = MailLog.paginate :page => params[:page], :order => 'created_at DESC', :conditions => conditions
  end
  
  def sent
    list 'success = true'
    render :action => 'list'
  end
  
  def unsent
    list 'success = false'
    render :action => 'list'
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