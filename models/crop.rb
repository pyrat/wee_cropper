require 'open-uri'
require 'digest/sha1'
class Crop
  
  def initialize(params, root)
    @params = params
    @root = root
  end
  
  # This performs the crop based on the actual parameters.
  # 1. Get image and store it in tmp
  # 2. Generate a resize command, run the command and save file to public dir.
  def engage
    resize_command = generate_resize_command()
    f_name = File.basename(@local_file.path) 
    @local_file.close
    `#{resize_command}`
    f_name
  end
  
  def generate_resize_command
    "convert #{image_src} -crop '#{@params[:crop_w]}x#{@params[:crop_h]}+#{@params[:crop_x]}+#{@params[:crop_y]}' +repage -resize '#{@params[:resize_info]}' #{image_dest}"
  end
  
  def image_src
    f = open(@params[:image_location]) 
    image_content = f.read
    @local_file = File.new(@root + "/tmp/images/#{get_identifier(f.base_uri.to_s)}#{get_extension(f)}", "w+")
    @local_file.write(image_content)
    @local_file.path
  end
  
  def get_extension(f)
    "." + f.base_uri.to_s.split("/").last.split(".").last
  end
  
  def image_dest
    raise StandardError, "No uploaded file to work with." unless @local_file
    @root + "/public/images/cropped/" + File.basename(@local_file.path) 
  end
  
  def get_identifier(filename)
    Digest::SHA1.hexdigest(filename + Time.now.to_s)
  end
end