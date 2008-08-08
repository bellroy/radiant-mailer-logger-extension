require File.dirname(__FILE__) + '/../spec_helper'

describe MailLog do
  before(:each) do
    @mail_log = MailLog.new(
      :success => true, 
      :form_name => 'Name of form', 
      :form_data => {:test => 'data'}
    )
  end

  it "should be valid" do
    @mail_log.should be_valid
  end
  
  describe 'form_data' do
    it 'should be serialized' do
      @mail_log.form_data = {'a' => 1, 'b' => 2}
      @mail_log.save!
      MailLog.find(@mail_log).form_data.should == {'a' => 1, 'b' => 2}
    end
    
    it 'should not store blank fields' do
      @mail_log.form_data = {:a => 1, :b => 2, :c => '', :d => '    ', :e => "\n\t", :f => nil}
      @mail_log.form_data.should == {:a => 1, :b => 2}
    end
  end
  
  describe 'to_s' do
    describe 'when name present' do
      it 'should return the name' do
        @mail_log.form_data = {'name' => 'monkey_dude'}
        @mail_log.to_s.should == 'monkey_dude'
      end
    end
    describe 'when name absent' do
      describe 'and email present' do
        it 'should return the email' do
          @mail_log.form_data = {'email' => 'monkey@dude.com'}
          @mail_log.to_s.should == 'monkey@dude.com'
        end
      end
      describe 'and email absent' do
        it 'should return something' do
          @mail_log.form_data = {}
          @mail_log.to_s.should_not be_nil
        end
      end
    end
  end
end
