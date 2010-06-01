# This is the main meat which will work with the
class Crop
  
  def initialize(params)
    @params = params
    engage
  end
  
  # This performs the crop based on the actual parameters.
  # 1. Get image and store it in tmp
  # 2. Generate a resize command, run the command and save file to tmp.
  # 3. Copy this file to S3
  def engage
    
  end
  
  # Generate a JSONP response to the server, with the href of the resized image.
  def to_json
    
  end
  
end