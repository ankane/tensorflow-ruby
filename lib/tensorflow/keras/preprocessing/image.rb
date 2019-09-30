module TensorFlow
  module Keras
    module Preprocessing
      module Image
        class << self
          def load_img(path, target_size: nil)
            img = MiniMagick::Image.open(path)
            if target_size
              size_str = target_size.map(&:to_i).join("x")
              img.resize "#{size_str}^", "-gravity", "center", "-extent", size_str
            end
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
