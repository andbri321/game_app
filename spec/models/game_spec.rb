require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    context do
      it {
        should validate_presence_of(:name)
      }
    end
  end
end
