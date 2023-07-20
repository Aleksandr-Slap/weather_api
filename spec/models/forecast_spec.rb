require 'rails_helper'

RSpec.describe Forecast, type: :model do
  it { should validate_presence_of :max }
  it { should validate_presence_of :min }
  it { should validate_presence_of :avg }
  it { should validate_presence_of :history }
end  