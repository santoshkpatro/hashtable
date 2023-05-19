class ApplicationController < ActionController::API
  def authenticate_user
    header = request.headers['Authorization']
    if header.nil?
      return render json: { message: 'No authentication token found' }, status: :not_found
    end
    token = header.split(' ').last

    begin
      decoded_data = User.decode_jwt_token(token)

      @current_user_id = decoded_data["user_id"]
      @current_role = decoded_data["role"]
      @current_organization_id = decoded_data["organization_id"]
    rescue Exception => e
      return render json: { message: e }, status: :forbidden
    end
  end
end
