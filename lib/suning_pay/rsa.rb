#encoding: utf-8
module SuningPay
  module RSA
    MAX_ENCRYPT_LENGTH = 245
    MAX_DECRYPT_LENGTH = 256

    #分段加密
    def self.encrypt_msg(key, message)
      code = Base64.encode64(message)
      puts code
      bytes_array = code.unpack("C*")
      input_length = bytes_array.length

      encryt_str, offset, i = "", 0, 0
      begin
        encryt_bytes = bytes_array[offset, MAX_ENCRYPT_LENGTH]
        #加密
        encryt_str << key.public_encrypt(encryt_bytes.pack("C*"))
        offset = (i += 1) * MAX_ENCRYPT_LENGTH
      end while input_length - offset > 0

      Base64::strict_encode64(encryt_str)
    end

    #分段解密
    def self.decrypt_msg(key, message)
      bytes_array = Base64::decode64 message
      input_length = bytes_array.length

      decryt_str, offset, i = "", 0, 0
      begin
        decryt_bytes = bytes_array[offset, MAX_DECRYPT_LENGTH]
        #解密
        decryt_str << key.private_decrypt(decryt_bytes)
        offset = (i += 1) * MAX_DECRYPT_LENGTH
      end while input_length - offset > 0

      decryt_str
    end

  end
end

