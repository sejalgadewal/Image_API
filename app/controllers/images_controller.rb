class ImagesController < ApplicationController
   
    def index
        images = Image.all
        image_urls = images.map do |event|
          rails_blob_path(event.image_file, only_path: true)
        end
        render json: { image_urls: image_urls }
      end
 
    def create
        event = Image.new(image_params)
        if event.save
          render json: { image_url: rails_blob_path(event.image_file, only_path: true) }, status: :created
        else
          render json: { error: 'Failed to upload image' }, status: :unprocessable_entity
        end
    end
    
    def show
        event=Image.find(params[:id])
        image_url=rails_blob_path(event.image_file, only_path: true)
        render json: image_url
    end

      private
    
      def image_params
        # params.require(:image).permit(:image_file)
        params.permit(:image_file)
        
      end
end
