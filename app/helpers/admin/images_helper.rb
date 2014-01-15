# Module for image related functions
module Admin::ImagesHelper
  private

# Delete tmp image directory if validation fails (for carrier wave)
  def remove_old_cache
    # get the model name
    model_name = controller_name.singularize
    # get image instance
    image = params[model_name]

    # if there is old cache delete
    if image[:image] && !image[:image_cache].empty?
      cache_name = image[:image_cache]
      # get the cache directory
      cache_dir = cache_name.split('/')[0]
      FileUtils.rm_rf(File.join("#{Rails.root}", '/public/uploads/tmp/', cache_dir))
    end
  end
end
