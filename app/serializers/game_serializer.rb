class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :total_kills, :players,
   :kills_by_means, :kills, :ranking

  def kills_by_means
    object.kills_by_means.sort_by { |h| h}.reverse.to_h
  end

  def kills
    get_kilss
  end

  def ranking
    get_kilss.keys
  end

  private
  
  def get_kilss
    ranking = object.kills.sort { |a, b| b[1] <=> a[1] }.reverse.to_h
  end
end
