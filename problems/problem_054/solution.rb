#!/usr/bin/env ruby

def flush?(hand)
  suit = hand.first[:suit]
  hand.all? { |card| card[:suit] == suit }
end

def straight?(faces)
  faces == (faces.min...(faces.min + 5)).to_a
end

def royal_flush_score()
  9_000_000
end

def straight_flush_score(faces)
  8_000_000 + faces.inject(:+)
end

def flush_score(faces)
  5_000_000 + faces.inject(:+)
end

def four_of_a_kind_score(groups)
  face1 = groups.find { |g| g.last == 1 }
  face4 = groups.find { |g| g.last == 4 }
  7_000_000 + face4.first * 14 + face1.first
end

def full_house_score(groups)
  face2 = groups.find { |g| g.last == 2 }
  face3 = groups.find { |g| g.last == 3 }
  6_000_000 + face3.first * 14 + face2.first
end

def straight_score(faces)
  4_000_000 + faces.min
end

def three_of_a_kind_score(groups)
  score = 3_000_000
  score += 14**2 * groups.find { |g| g.last == 3 }.first
  groups.select { |g| g.last == 1 }.map { |g| g.first }.sort.each_with_index { |v, i| score += 14**i * v }
  score
end

def two_pairs_score(groups)
  score = 2_000_000
  score += groups.find { |g| g.last == 1 }.first
  groups.select { |g| g.last == 2 }.map { |g| g.first }.sort.each_with_index { |v, i| score += 14**(i + 1) * v }
  score
end

def one_pair_score(groups)
  score = 1_000_000
  score += 14**3 * groups.find { |g| g.last == 2 }.first
  groups.select { |g| g.last == 1 }.map { |g| g.first }.sort.each_with_index { |v, i| score += 14**i * v }
  score
end

def get_score(hand)
  faces = hand.map { |card| card[:face] }.sort
  if flush?(hand)
    return flush_score(faces) unless straight?(faces)
    return royal_flush_score if faces.min == 10
    straight_flush_score(faces)
  else
    groups = faces.group_by { |f| f }.map { |g| [g.first, g.last.size] }
    if groups.size == 2
      return four_of_a_kind_score(groups) if groups.any? { |g| g.last == 4 }
      return full_house_score(groups)
    end
    return straight_score(faces) if straight?(faces)
    return three_of_a_kind_score(groups) if groups.any? { |g| g.last == 3 }
    return two_pairs_score(groups) if groups.select { |g| g.last == 2 }.size == 2
    return one_pair_score(groups) if groups.any? { |g| g.last == 2 }

    score = 0
    faces.each_with_index { |v,i| score += 14**i * v }
    score
  end
end

def map_hand(cards)
  value_map = { T: 10, J: 11, Q: 12, K: 13, A: 14 }
  cards.map do |card|
    face, suit = card.split(//).map(&:upcase)
    { face: value_map.fetch(face.to_sym, face.to_i), suit: suit.to_sym }
  end
end

num_p1_wins = 0

File.readlines(File.join(File.dirname(__FILE__), '..', 'data', 'poker.txt')).each do |line|
  cards1, cards2 = line.split(/ /).each_slice(5).to_a

  score1 = get_score(map_hand(cards1))
  score2 = get_score(map_hand(cards2))

  num_p1_wins += 1 if score1 > score2
end

puts num_p1_wins
