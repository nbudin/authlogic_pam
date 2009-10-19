module AuthlogicPam
  module ActsAsAuthentic
    def self.included?(klass)
      klass.class_eval do
        extend Config
        add_acts_as_authentic_module(Methods, :prepend)
      end
    end
    
    module Config
      def validate_pam_login(value = nil)
        config(:validate_pam_login. value, true)
      end
      alias_method :validate_pam_login=, :validate_pam_login
    end
    
    module Methods
      def self.included?(klass)
        klass.class_eval do
          attr_accessor :pam_password
          
          if validate_pam_login
            validates_uniqueness_of :pam_login, :scope => validations_scope, :if => :using_pam?
            validates_presence_of :pam_password, :if => :validate_pam?
            validate :validate_pam, :if => :validate_pam?
          end
        end
      end
      
      private
      def using_pam?
        respond_to?(:pam_login) && respond_to?(:pam_password) &&
          (!pam_login.blank? || !pam_password.blank?)
      end
      
      def validate_pam
        return if errors.count > 0
      end
      
      def validate_pam?
        pam_login_changed? && !pam_login.blank?
      end
    end
  end
end
