# frozen_string_literal: true

module Log
  class GameKill < ApplicationService
    def initialize(file_name)
      @file_name = file_name
      @game_number = 1
      @games = {}
    end

    def read
      File.readlines(@file_name, chomp: true).each do |line|
        if line.include?('InitGame')
          create_game
        elsif line.include?('ClientUserinfoChanged')
          insert_players(line)
        elsif line.include?('killed')
          insert_kills(line)
        end
      end
      @games
    end

    def save
      read.each_key do |key|
        object = @games[key].merge(name: key)
        new_game = Game.new(object)
        if new_game.save
          Rails.logger.info "#{new_game.name} successfully created"
        else
          Rails.logger.error "Create #{new_game.name} failed. Erros: #{new_game.errors.full_messages.join(' | ')}"
        end
      end
    end

    private

    def create_game
      @game_name = "game_#{@game_number}"
      @games.merge!(scaffold)
      @game_number += 1
    end

    def insert_players(line)
      player = line.split('\\')[1]
      return if @games[@game_name.to_s]['players'].include?(player)

      @games[@game_name.to_s]['players'] << player
    end

    def insert_kills(line)
      @games[@game_name.to_s]['total_kills'] += 1
      add_kills(line)
      add_kills_by_means(line)
    end

    def scaffold
      {
        @game_name => {
          'total_kills' => 0,
          'players' => [],
          'kills' => {},
          'kills_by_means' => {}
        }
      }
    end

    def add_kills(line)
      new_key = line.split('by')[0].split('killed')[1].strip
      kills = @games[@game_name.to_s]['kills'].with_indifferent_access
      new_kills = counter(line, new_key, kills, false)
      @games[@game_name.to_s]['kills'].merge!(new_kills)
    end

    def add_kills_by_means(line)
      new_key = line.split('by')[1].strip
      kills_by_means = @games[@game_name.to_s]['kills_by_means'].with_indifferent_access
      new_kills_by_means = counter(line, new_key, kills_by_means)
      @games[@game_name.to_s]['kills_by_means'].merge!(new_kills_by_means)
    end

    def counter(_line, new_key, hash, _increment_counter = true)
      if hash.empty? || !hash&.key?(new_key)
        value = 1
      elsif hash&.key?(new_key)
        value = hash[new_key] + 1
      end
      hash.merge!({ "#{new_key}": value }).with_indifferent_access
    end
  end
end
