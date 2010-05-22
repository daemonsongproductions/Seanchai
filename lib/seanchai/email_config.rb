module Seanchai
  class EmailConfig

    require 'yaml'

    attr_reader :email_config


    #smtp settings are: address, domain, port, authentication method, username, password
    #sendmail settings are: location, arguments

    def initialize
      @email_config = YAML.load_file 'config/email.yml'
    end


    def setup_action_mailer(action_mailer)

      delivery_method = @email_config['delivery_method']

      case delivery_method
        when :smtp
          action_mailer.smtp_settings = email_settings(delivery_method.to_s)
        when :sendmail
          action_mailer.sendmail_settings = email_settings(delivery_method.to_s)
        else
          raise "You do not have a valid delivery_method set in config/email.yml.  Available delivery methods are smtp and sendmail"
      end

      action_mailer.delivery_method = delivery_method

    end

    private

    def email_settings(delivery_method)
      smtp_settings = {}
      @email_config[delivery_method].each do |key, value|
        smtp_settings[key.to_sym] = value
      end
      smtp_settings
    end

  end
end
