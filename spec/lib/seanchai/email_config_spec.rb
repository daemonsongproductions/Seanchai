require 'spec_helper'

describe Seanchai::EmailConfig do

  def smtp_host_hash

    { :address => "mail.test.com",
      :domain => 'test.com',
      :port => 25
    }

  end

  def smtp_authentication_hash
    { :authentication => :login,
      :user_name => 'tester@test.com',
      :password => 'password'
    }
  end

  def sendmail_hash
    { :location => '/usr/sbin/sendmail',
      :arguments => '-it'        
    }
  end

  def get_email_config(config_yaml_path)
    test_yaml = YAML.load_file config_yaml_path
    YAML.should_receive(:load_file).and_return(test_yaml)
    Seanchai::EmailConfig.new
  end

  def get_mock_action_mailer(options)
    mock_action_mailer = mock(ActionMailer)
    mock_action_mailer.should_receive(:delivery_method=).with(options[:delivery_method])

    if options[:delivery_method] == :smtp
      smtp_hash = smtp_host_hash
      smtp_hash.merge!(smtp_authentication_hash) if options[:authenticated]
      mock_action_mailer.should_receive(:smtp_settings=).with(hash_including(smtp_hash))
    elsif options[:delivery_method] == :sendmail
      mock_action_mailer.should_receive(:sendmail_settings=).with(hash_including(sendmail_hash))
    end

    mock_action_mailer
    
  end


  it "should load the correct settings when smtp with authentication is set as the delivery method is specified" do

    email_config = get_email_config 'spec/test_data/email_config_smtp_authenticated.yml'
    
    mock_action_mailer = get_mock_action_mailer(:delivery_method => :smtp, :authenticated => true)

    email_config.setup_action_mailer mock_action_mailer
  end
  
  it "should load the correct settings when smtp without authentication is set as the delivery method" do

    email_config = get_email_config 'spec/test_data/email_config_smtp_unauthenticated.yml'
    
    mock_action_mailer = get_mock_action_mailer(:delivery_method => :smtp, :authenticated => false)
    email_config.setup_action_mailer mock_action_mailer

  end

  it "should load the correct settings when sendmail is set as the delivery method" do
    email_config = get_email_config 'spec/test_data/email_config_sendmail.yml'

    mock_action_mailer = get_mock_action_mailer(:delivery_method => :sendmail)
    email_config.setup_action_mailer mock_action_mailer
  end

end