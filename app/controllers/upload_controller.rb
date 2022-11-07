class UploadController < ActiveStorage::DiskController
  def update
    request.env['RAW_POST_DATA'] = request.body.read(request.content_length)
    super
  end
end
