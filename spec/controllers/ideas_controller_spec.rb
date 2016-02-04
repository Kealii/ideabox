require 'rails_helper'

describe IdeasController do
  describe 'index' do
    it 'returns all ideas in reverse chronological order' do
      idea1 = Idea.create!(title: 'Foo',     body: 'Idea 1 Body')
      idea2 = Idea.create!(title: 'Bar',     body: 'Idea 2 Body')
      idea3 = Idea.create!(title: 'Central', body: 'Idea 3 Body')
      get :index

      parsed = JSON.parse(response.body)['ideas']
      expect(parsed).to eq [{'id' => idea3.id, 'title' => 'Central', 'body' => 'Idea 3 Body', 'rating' => 0},
                            {'id' => idea2.id, 'title' => 'Bar', 'body' => 'Idea 2 Body', 'rating' => 0},
                            {'id' => idea1.id, 'title' => 'Foo', 'body' => 'Idea 1 Body', 'rating' => 0}]
    end

    it 'can filter idea title by query param' do
      idea1 = Idea.create!(title: 'Foo',     body: 'Idea 1 Body')
      idea2 = Idea.create!(title: 'Bar',     body: 'Idea 2 Body')
      idea3 = Idea.create!(title: 'Central', body: 'Idea 3 Body')

      get :index, q: 'Fo'

      parsed = JSON.parse(response.body)['ideas']
      expect(parsed).to eq [{'id' => idea1.id, 'title' => 'Foo', 'body' => 'Idea 1 Body', 'rating' => 0}]

    end

    it 'can filter idea body query param' do
      idea1 = Idea.create!(title: 'Foo',     body: 'Idea 1 Body')
      idea2 = Idea.create!(title: 'Bar',     body: 'Idea 1 Body')
      idea3 = Idea.create!(title: 'Central', body: 'Idea 3 Body')

      get :index, q: 'Idea 1'

      parsed = JSON.parse(response.body)['ideas']
      expect(parsed).to eq [{'id' => idea2.id, 'title' => 'Bar', 'body' => 'Idea 1 Body', 'rating' => 0},
                            {'id' => idea1.id, 'title' => 'Foo', 'body' => 'Idea 1 Body', 'rating' => 0}]

    end
  end
end