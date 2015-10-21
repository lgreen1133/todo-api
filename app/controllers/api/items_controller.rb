class Api::ItemsController < ApiController
  before_action :authenticated?

  def create
    item = Item.new(item_params)
    item.list = List.find(params[:list_id])
      if item.save
        render json: item 
      else
        render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
      end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: item 
    else 
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy 
    begin 
      item = Item.find(params[:id])
      item.destroy

      render json: {success: true} #, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render json: {success: false}, :status => :not_found
    end
  end 

  private

  def item_params
    params.require(:item).permit(:name, :complete)
  end

end