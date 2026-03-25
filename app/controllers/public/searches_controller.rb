class Public::SearchesController < Public::ApplicationController
  allow_unauthenticated_access only: %i[index]

  def index
    @keyword = params[:keyword].to_s.strip
    @items = Item.where(is_active: true)

    return if @keyword.blank?

    escaped_keyword = ActiveRecord::Base.sanitize_sql_like(@keyword)
    @items = @items.where("name LIKE ?", "%#{escaped_keyword}%")
  end
end
