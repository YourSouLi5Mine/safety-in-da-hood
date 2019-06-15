if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = true
  end

  PictureUploader

  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "test/uploads/tmp"
      end

      def store_dir
        "test/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end
