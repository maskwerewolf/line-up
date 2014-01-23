class Encrypt
  require 'openssl'
  require 'base64'
  ALG = 'DES-EDE3-CBC'
  KEY = 'FuCk&YOU'
  DES_KEY = 'You&Fuck'
  #AES CAST5 BF DES IDEA RC2 RC4 RC5
  def self.encode(str)
    des = OpenSSL::Cipher::Cipher.new(ALG)
    des.pkcs5_keyivgen(KEY, DES_KEY)
    des.encrypt
    cipher = des.update(str)
    cipher << des.final
    return Base64.encode64(cipher)
  end

  def self.decode(str)
    str = Base64.decode64(str)
    des = OpenSSL::Cipher::Cipher.new(ALG)
    des.pkcs5_keyivgen(KEY, DES_KEY)
    des.decrypt
    des.update(str) + des.final
  end
end



