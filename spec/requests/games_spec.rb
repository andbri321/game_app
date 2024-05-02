require 'rails_helper'

RSpec.describe "/games", type: :request do
  describe "GET /index" do
    context 'When does NOT have any game' do
      before { get games_path, as: :json }
      it{ expect(response).to have_http_status(:success) }
  
      it "returns only the metadata" do
        json_expected = {:games=>[], :meta=>{:current_page=>1, :next_page=>nil, :prev_page=>nil, :next_page_link=>nil, :prev_page_link=>nil, :per_page=>10, :total_pages=>0, :total_count=>0}}
  
        expect(json_response).to eq(json_expected)
      end
    end

    context 'When does have games' do
      let(:except_keys){ ['created_at','updated_at','ranking'] }
      let!(:game){ create(:game_with_players_kills) }
      before { get games_path, as: :json }

      it{ expect(response).to have_http_status(:success) }
  
      it "returns games" do
        games_json = json_response[:games][0].with_indifferent_access.except(*except_keys)

        expect(games_json).to eq(game.as_json.except(*except_keys))
      end
    end
  end
end
