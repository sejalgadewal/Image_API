class PersonalDetailsController < ApplicationController
    before_action :set_personal_detail, only: %i[ show edit update destroy ]
  
    def index
      @personal_details = PersonalDetail.all
      render json: @personal_details
    #   begin
    #     @personal_details = PersonalDetail.all
    #     render json: @personal_details
    #   rescue => e
    #     render json: { error: e.message }, status: :unprocessable_entity
    #   end
    end
  
    def new
      @personal_detail=PersonalDetail.new
    end
  
    def create
      
        @personal_detail = PersonalDetail.new(personal_detail_params)
        @personal_detail.image = rails_blob_path(@personal_detail.image_file)
        @personal_detail.video = rails_blob_path(@personal_detail.video_file)
      
        if @personal_detail.save
            
            render json: {personal_detail: @personal_detail }, status: :created
        else
          render json: { errors: @personal_detail.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
  
    def edit
        
    end
    
    def update
      respond_to do |format|
        if @personal_detail.update(personal_detail_params)
          format.html { redirect_to personal_detail_url(@personal_detail), notice: "Detail was successfully updated." }
          format.json { render :show, status: :created, location: @personal_detail }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @personal_detail.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def show
  
    end
  
    def destroy
      @personal_detail.destroy
      respond_to do |format|
        format.html { redirect_to personal_details_url, notice: "Detail was successfully destroyed." }
        format.json { head :no_content }
      end
    end
    
    private
  
      def personal_detail_params
        # params.permit(:mobile, :email, :gender, :dob, :marital_status, :blood_group, :image, :video)
        params.permit(:mobile, :email, :gender, :dob , :marital_status, :blood_group, :image_file, :video_file)
      end
  
      def set_personal_detail
        @personal_detail = PersonalDetail.find(params[:id])
      end
  
  
  end
  