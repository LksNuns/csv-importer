class SaleUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/csv_sales_files/"
  end

  def filename
    "#{Time.now.to_i}_#{original_filename}"
  end

  def extension_whitelist
    %w(csv, txt)
  end
end
