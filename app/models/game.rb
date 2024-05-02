# frozen_string_literal: true

class Game < ApplicationRecord
    paginates_per 10

    validates :name, presence: true
end
