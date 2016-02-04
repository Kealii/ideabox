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

  describe 'save' do
    it 'does not truncate less than 100 characters' do
      body = ''
      100.times { body += 'A' }
      idea = Idea.new(body: body)
      idea.save

      expect(idea.body).to eq body
    end

    it 'truncates to the nearest word' do
      body = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam id risus euismod, faucibus est sed amet.'
      idea = Idea.new(body: body)
      idea.save

      expect(idea.body).to eq 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam id risus euismod, faucibus est sed'
    end
  end
end