require 'base'
require 'spec_helper'

describe Base do
  it "should allow us to create a base object" do
    base = Base.new("abcde")
    base.should be
  end
end