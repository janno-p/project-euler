#!/usr/bin/env ruby

ranks = [
  :high_card => 'Highest value card',
  :one_pair => 'Two cards of the same value',
  :two_pairs => 'Two different pairs',
  :three_of_a_kind => 'Three cards of the same value',
  :straight => 'All cards are consecutive values',
  :flush => 'All cards of the same suit',
  :full_house => 'Three of a kind and a pair',
  :four_of_a_kind => 'Four cards of the same value',
  :straight_flush => 'All cards are consecutive values of same suit',
  :royal_flush => 'Ten, Jack, Queen, King, Ace, in same suit'
]

def score(hand)
end


File.readlines(File.join(File.dirname(__FILE__), '..', 'data', 'poker.txt')).each do |line|
  puts line
end
