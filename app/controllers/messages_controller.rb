class MessagesController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    from_type = type_array[0]
    from_id = type_array[1]
    @from = from_type.constantize.find(from_id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

   private
    def whitelist
      params.require(:message).permit(:content, :subject)
    end

    def type_array
      JSON.parse(params.permit(:type_array)[:type_array])
    end

end
