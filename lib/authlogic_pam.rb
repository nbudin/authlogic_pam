require 'authlogic'
require 'authlogic_pam/acts_as_authentic'
require 'authlogic_pam/session'

module AuthlogicPam
  VERSION = '0.1.0'
end

#ActiveRecord::Base.send(:include, AuthlogicPam::ActsAsAuthentic)
Authlogic::Session::Base.send(:include, AuthlogicPam::Session)