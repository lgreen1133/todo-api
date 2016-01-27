class Api::ListsController < ApiController
  before_action :authenticated?

  def index
    if params[:name].present?
      lists = current_user.lists.where('name LIKE ?', "%#{params[:name]}%")
    else
      lists = current_user.lists
    end
      render json: lists
  end

  def create
    list = List.new(list_params)

    authorize list 

    list.user = User.find(params[:user_id])
      if list.save
        render json: list
      else 
        render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
      end
  end

  def update
    list = List.find(params[:id])

    authorize list 

    if list.update(list_params)
      render json: list 
    else 
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      list = List.find(params[:id])
      if authorize list
        list.destroy
      else
        render json: {success: false}
      end

      render json: {success: true} #, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render json: {success: false}, :status => :not_found
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :permissions, :complete)
  end

end