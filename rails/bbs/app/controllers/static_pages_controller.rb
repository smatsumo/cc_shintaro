require "csv"   
class StaticPagesController < ApplicationController
  def top
    
    # csv = CSV.read('tmp/tweets.csv')
    # @tweets = csv
    @tweets = Tweet.all   
  end
end