require 'json'
require 'pry'

module Parser
  def self.parse_payload(json_string)
    parsed = JSON.parse(json_string)
    parsed.reduce(Hash.new) do |hash, (key, value)|
      new_key = key.dup
      hash[to_snakecase(new_key)] = value
      hash
    end
  end

  def to_snakecase(word)
    word.gsub(/(.)([A-Z])/, '\1_\2').downcase.to_sym
  end
end
