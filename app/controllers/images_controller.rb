class ImagesController < ApplicationController

      def index
        images = Image.all
        image_urls = images.map do |image|   
          if image.image_file.attached?
            image.convert_to_svg
            rails_blob_path(image.image_file, only_path: true)
          else
            nil
          end
        end.compact  # Remove nil values
        render json: { image_urls: image_urls }
      end
 
    def create
        event = Image.new(image_params)
        if event.save
          event.convert_to_svg
          render json: { image_url: rails_blob_path(event.image_file, only_path: true) }, status: :created
        else
          render json: { error: 'Failed to upload image' }, status: :unprocessable_entity
        end
    end
    
    def show
        event=Image.find(params[:id])
        if event.image_file.attached?
          event.convert_to_svg
          image_url=rails_blob_path(event.image_file, only_path: true)
        else
          nil
        end
      
        render json: image_url
    end

      private
    
      def image_params
        # params.require(:image).permit(:image_file)
        params.permit(:image_file)
        
      end
end
