require 'fileutils'
require 'shellwords'

class XmlConverterInteractor
  def initialize(nfe_keys, customer)
    @nfe_keys = nfe_keys
    @customer = customer.to_s
    @file_paths = []
  end

  def execute
    @nfe_keys.each do |nfe_key|
      service_response = ConverterService.new(nfe_key).execute
      @file_paths << write_to_xml(nfe_key, service_response)
    end

    create_tar_gz_archive
  end

  def write_to_xml(key, content)
    filepath = File.expand_path("#{filepath_xml}/#{key}.xml")

    FileUtils.mkdir_p(File.dirname(filepath))
    File.write(filepath, content)

    # Copy the file to the public directory
    public_filepath = File.join(Rails.root, 'public', 'nfe_xmls', @customer, "#{key}.xml")
    FileUtils.mkdir_p(File.dirname(public_filepath))
    FileUtils.cp(filepath, public_filepath)

    public_filepath
  end

  def filepath_xml
    # Use the public directory to construct an absolute path
    year_fold = Time.current.year
    month_fold = Time.current.month

    full_path = File.join(Rails.root, 'public', 'nfe_xmls', @customer, year_fold.to_s, month_fold.to_s)

    full_path
  end

  def full_file_paths
    @file_paths.compact # Ensure no nil values are returned
  end

  def create_tar_gz_archive
    month_folder = filepath_xml
    tar_gz_file = File.join(Rails.root, 'public', 'nfe_xmls', "#{@customer}_#{Time.current.year}_#{Time.current.month}.tar.gz")
    temp_folder = File.join(Rails.root, 'public', 'nfe_xmls', "#{@customer}_#{Time.current.year}_#{Time.current.month}")

    # Create a temporary directory with the same name as the tar file (without extension)
    FileUtils.mkdir_p(temp_folder)

    # Copy all XML files to the temporary directory
    Dir.glob("#{month_folder}/*.xml").each do |xml_file|
      FileUtils.cp(xml_file, temp_folder)
    end

    # Create the tar.gz archive with the temporary directory
    escaped_temp_folder = Shellwords.escape(temp_folder)
    escaped_tar_gz_file = Shellwords.escape(tar_gz_file)

    system("tar -czvf #{escaped_tar_gz_file} -C #{File.dirname(escaped_temp_folder)} #{File.basename(escaped_temp_folder)}")
    puts "========================================"
    puts "TAR.GZ file created at: " + tar_gz_file
    puts "========================================"

    # Clean up the temporary directory
    FileUtils.rm_rf(temp_folder)

    tar_gz_file
  end
end