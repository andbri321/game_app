# frozen_string_literal: true

# GameKillJob ApplicationJob
class GameKillJob < ApplicationJob
  queue_as :default

  def perform(file)
    Log::GameKill.new(file).save
  end
end
