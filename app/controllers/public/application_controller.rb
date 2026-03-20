class Public::ApplicationController < ApplicationController
  include Public::Authentication

  before_action :set_genres

  private

  def set_genres
    @genres = Genre.all
  end
end