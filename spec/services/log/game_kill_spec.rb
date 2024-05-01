# frozen_string_literal: true

require 'rails_helper'
describe Log::GameKill do
  let(:log_game_kill) { Log::GameKill.new('qgames3.log') }

  describe 'call .save' do
    let!(:call_save) { log_game_kill.save }
    context 'create games' do
      it 'create games list' do
        expect(Game.count).to eq(21)
      end
    end
  end

  describe 'call .save' do
    let(:game_kill) { log_game_kill.read }

    context 'when read file' do
      it 'create game 1 record' do
        json_expected = {
          'game_1' => {
            'total_kills' => 0,
            'players' => [
              'Isgalamido'
            ],
            'kills' => {},
            'kills_by_means' => {}
          }
        }
        expect(game_kill['game_1']).to eq(json_expected.with_indifferent_access['game_1'])
      end

      it 'create game 2 record' do
        json_expected = {
          'game_2' => {
            'total_kills' => 11,
            'players' => [
              'Isgalamido', 'Dono da Bola', 'Mocinha'
            ],
            'kills' => {
              'Isgalamido' => 10,
              'Mocinha' => 1
            },
            'kills_by_means' => {
              "MOD_TRIGGER_HURT": 7,
              "MOD_ROCKET_SPLASH": 3,
              "MOD_FALLING": 1
            }
          }
        }

        expect(game_kill['game_2']).to eq(json_expected.with_indifferent_access['game_2'])
      end

      it 'create game 3 record' do
        json_expected = {
          'game_3' => {
            "kills_by_means": {
              "MOD_ROCKET": 1,
              "MOD_TRIGGER_HURT": 2,
              "MOD_FALLING": 1
            },
            "total_kills": 4,
            "players": ['Dono da Bola', 'Mocinha', 'Isgalamido', 'Zeh'],
            "kills":
              {
                "Mocinha": 1,
                "Zeh": 2,
                "Dono da Bola": 1
              }
          }
        }

        expect(game_kill['game_3']).to eq(json_expected.with_indifferent_access['game_3'])
      end

      it 'create game 5 record' do
        json_expected = {
          'game_5' => {
            "kills_by_means": {
              "MOD_ROCKET": 4,
              "MOD_ROCKET_SPLASH": 4,
              "MOD_TRIGGER_HURT": 5,
              "MOD_RAILGUN": 1
            },
            "total_kills": 14,
            "players": ['Dono da Bola', 'Isgalamido', 'Zeh', 'Assasinu Credi'],
            "kills":
              {
                "Zeh": 5,
                "Dono da Bola": 1,
                "Assasinu Credi": 8
              }
          }
        }
        expect(game_kill['game_5']).to eq(json_expected.with_indifferent_access['game_5'])
      end
    end
  end
end
