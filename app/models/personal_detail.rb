class PersonalDetail < ApplicationRecord
    has_one_attached :image_file
    has_one_attached :video_file

end
