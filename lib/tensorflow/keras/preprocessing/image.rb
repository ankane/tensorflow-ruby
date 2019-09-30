module TensorFlow
  module Keras
    module Preprocessing
      module Image
        class << self
          def load_img(path, target_size: nil)
            img = MiniMagick::Image.open(path)
            if target_size
              img.resize "#{target_size.map(&:to_i).join("x")}!", "-filter", "point"
            end
            # img.write("/tmp/resized.jpg")
            img
          end

          def img_to_array(img)
            Numo::SFloat.cast(img.get_pixels)
          end
        end
      end
    end
  end
end
