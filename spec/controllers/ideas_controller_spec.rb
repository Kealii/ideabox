require 'rails_helper'

describe IdeasController do
  describe 'index' do
    it 'returns all ideas in reverse chronological order' do
      idea1 = Idea.create!(title: 'Foo',     body: 'Idea 1 Body')
      idea2 = Idea.create!(title: 'Bar',     body: 'Idea 2 Body')
      idea3 = Idea.create!(title: 'Central', body: 'Idea 3 Body')
      get :index

      parsed = JSON.parse(response.body)['ideas']
      expect(parsed).to eq [{'id' => idea3.id, 'title' => 'Central', 'body' => 'Idea 3 Body'},
                            {'id' => idea2.id, 'title' => 'Bar', 'body' => 'Idea 2 Body'},
                            {'id' => idea1.id, 'title' => 'Foo', 'body' => 'Idea 1 Body'}]
    end
  end
end