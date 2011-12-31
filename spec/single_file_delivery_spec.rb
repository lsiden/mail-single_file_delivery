# encoding: utf-8

require 'mail-single_file_delivery'
require 'mail'

describe Mail::SingleFileDelivery::Agent do

  before(:each) do
    # Reset all defaults back to an original state
    Mail.defaults do
      delivery_method :smtp, { :address              => "localhost",
                               :port                 => 25,
                               :domain               => 'localhost.localdomain',
                               :user_name            => nil,
                               :password             => nil,
                               :authentication       => nil,
                               :enable_starttls_auto => true  }
    end
  end
  
  after(:each) do
  end

  it "should respond to #settings() and #settings=()" do
    subject.should respond_to :settings
    subject.should respond_to :settings=
  end

  it "should respond to #deliver!()" do
    subject.should respond_to :deliver!
  end
  
  describe "general usage" do
    the_file = '/tmp/mail-single_file'

    before(:all) do
    end

    it "should send an email to a single file" do
      Mail.defaults do
        delivery_method Mail::SingleFileDelivery::Agent, :filename => the_file
      end
      mail = Mail.deliver do
        from    'roger@moore.com'
        to      'marcel@amont.com'
        subject 'invalid RFC2822'
      end
      File.read(the_file).should == mail.encoded
    end

    it "should send multiple emails to a single file" do
      Mail.defaults do
        delivery_method Mail::SingleFileDelivery::Agent, :filename => the_file
      end
      mail = Mail.deliver do
        from    'roger@moore.com'
        to      'marcel@amont.com, bob@me.com'
        subject 'invalid RFC2822'
      end
      mail2 = Mail.deliver do
        from    'roger@moore.com'
        to      'marcel@amont.com, bob@me.com'
        subject 'invalid RFC2822'
      end
      File.read(the_file).should == mail.encoded + mail2.encoded
    end
  end
end
