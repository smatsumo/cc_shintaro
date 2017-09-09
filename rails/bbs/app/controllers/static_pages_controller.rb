require "csv"   
class StaticPagesController < ApplicationController
  def top
    csv = CSV.read('tmp/tweets.csv')
    @tweets = csv
  end
end