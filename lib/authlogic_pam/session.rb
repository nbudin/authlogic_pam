require 'rpam'

module AuthlogicPam
  module Session
    def self.included(klass)
      klass.class_eval do
        extend Config
        include Methods
        include Rpam
      end
    end
    
    module Config
      def find_by_pam_login_method(value = nil)
        rw_config(:find_by_pam_login_method, value, :find_by_pam_login)
      end
      alias_method :find_by_pam_login_method=, :find_by_pam_login_method
    end
    
    module Methods
      def self.included(klass)
        klass.class_eval do
          attr_accessor :pam_login
          attr_accessor :pam_password
          
          validate :validate_by_pam, :if => :authenticating_with_pam?
        end
      end
      
      def credentials
        if authenticating_with_pam?
          details = {}
          details[:pam_login] = send(login_field)
          details[:pam_password] = '<protected>'
          details
        else
          super
        end
      end
      
      def credentials=(value)
        super
        values = value.is_a?(Array) ? value : [value]
        hash = values.first.is_a?(Hash) ? values.first.with_indifferent_access : nil
        if !hash.nil?
          self.pam_login = hash[:pam_login] if hash.key?(:pam_login)
          self.pam_password = hash[:pam_password] if hash.key?(:pam_password)
        end
      end
      
      private
      def authenticating_with_pam?
        !pam_login.blank? || !pam_password.blank?
      end
      
      def find_by_pam_login_method
        self.class.find_by_pam_login_method
      end
      
      def validate_by_pam
        errors.add(:pam_login, I18n.t('error_messages.pam_login_blank', :default => 'cannot be blank')) if pam_login.blank?
        errors.add(:pam_password, I18n.t('error_messages.pam_password_blank', :default => 'cannot be blank')) if pam_password.blank?
        return if errors.count > 0
        
        if authpam(pam_login, pam_password)
          self.attempted_record = klass.send(find_by_pam_login_method, pam_login)
          errors.add(:pam_login, I18n.t('error_messages.pam_login_not_found', :default => "does not exist")) if attempted_record.blank?
        else
          errors.add(:base, "PAM authentication failed")
        end
      end
    end
  end
end
