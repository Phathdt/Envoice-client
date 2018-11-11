module Decoder
  def self.perform(hash)
    [hash].pack('H*').force_encoding('utf-8')
  end
end
