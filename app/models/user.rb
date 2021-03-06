class User < ActiveRecord::Base
	has_many :articles
	has_many :highlights
	has_many :collections

	has_many :topic_users, :class_name => 'TopicUser'
	has_many :topics, :through => :topic_users

	EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, :presence => true, uniqueness: true, :format => EMAIL_REGEX
	validates :name, :presence => true
	validates :password, :presence => true 
	#note:password is not in the usermodel, encrypted_password is.
	before_save :encrypt_password, :ensure_authentication_token!
	after_save :clear_password

	attr_accessor :password

	''' Password Encryption '''
	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
	  end
	end

	def clear_password
	  self.password = nil
	end

	'''Authentication Token'''
	def ensure_authentication_token!
	    if authentication_token.blank?
	      self.authentication_token = generate_authentication_token
	    end
	end

    def generate_authentication_token
    	loop do
      		token = generate_secure_token_string
      		break token unless User.where(authentication_token: token).first
    	end
    end

    def generate_secure_token_string
    	SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  	end

  	def reset_authentication_token!
    	self.authentication_token = generate_authentication_token
  	end





end
