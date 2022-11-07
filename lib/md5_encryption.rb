module Md5Encryption
  require 'digest'

  def self.encrypt(input_string, salt)
    Digest::MD5.hexdigest(input_string + salt)
  end
end