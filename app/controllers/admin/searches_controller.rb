class Admin::SearchesController < Admin::ApplicationController
  def index
    @keyword = params[:keyword].to_s.strip
    @range = params[:range] == "customer" ? "customer" : "item"

    if @range == "customer"
      @customers = Customer.all
      return if @keyword.blank?

      escaped_keyword = ActiveRecord::Base.sanitize_sql_like(@keyword)
      @customers = @customers.where(
        "last_name LIKE :keyword OR first_name LIKE :keyword",
        keyword: "%#{escaped_keyword}%"
      )
      return
    end

    @items = Item.includes(:genre)
    return if @keyword.blank?

    escaped_keyword = ActiveRecord::Base.sanitize_sql_like(@keyword)
    @items = @items.where("name LIKE ?", "%#{escaped_keyword}%")
  end
end
