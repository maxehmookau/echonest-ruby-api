require "echonest-ruby-api/version"
require_relative 'base'

module Echonest

  def self.initialize(api_key)
    @base = Base.new(api_key)
  end

end
