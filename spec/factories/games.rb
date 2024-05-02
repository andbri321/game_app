# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    name { Faker::Lorem.sentence }
    total_kills { 0 }
    players { [] }
    kills { {} }

    trait :with_players do
      players { ['Isgalamido', 'Mocinha', 'Dono da Bola'] }
    end

    trait :with_kills do
      kills do
        {
          'MOD_TRIGGER_HURT' => 3,
          'MOD_FALLING' => 1,
          'MOD_ROCKET' => 5,
          'MOD_RAILGUN' => 2
        }
      end
    end

    factory :game_with_players_kills, traits: %i[with_players with_kills]
    # rubocop
  end
end
