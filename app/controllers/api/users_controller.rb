class Api::UsersController < ApiController
  before_action :authenticated?

  respond_to :json

  def index
    users = User.all 
    
    render json: users, each_serializer: UserSerializer
  end

  private

  # This is for the following checkpoint
  
  # def new 
  #   user = User.new
  # end

  # def create
  #     user = User.create(user_params)
  #   if user.save
  #     render json: user
  #   else
  #     render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # private

  # def user_params
  # params.require(:user).permit(:username, :password)
  # end

end