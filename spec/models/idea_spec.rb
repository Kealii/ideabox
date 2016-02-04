require 'rails_helper'

describe Idea do
  describe 'validations' do
    let(:idea) {
      Idea.new(rating: 1)
    }
    it 'can be valid' do
      expect(idea).to be_valid
    end

    it 'must be less than 3' do
      idea.rating = 3
      expect(idea).to be_invalid
      expect(idea.errors[:rating]).to include('must be less than 3')
    end

    it 'must be greater than or equal to 0' do
      idea.rating = -1
      expect(idea).to be_invalid
      expect(idea.errors[:rating]).to include('must be greater than -1')
    end
  end
end