# frozen_string_literal: true

class CloudinaryService
  def self.upload(attachment)
    res = Cloudinary::Uploader.upload(attachment.tempfile, folder: 'rails_test_project/')
    res['url']
  end

  def self.batch_upload(object, attachments)
    unless object.nil?
      attachments.each do |file|
        res = Cloudinary::Uploader.upload(file.tempfile, folder: 'rails_test_project/')
        attachment = object.attachments.new
        attachment.uri = res['url']
        attachment.save
      end
    end
  end

  def self.destroy(attachment)
    uri = attachment.uri.split('/', -1)
    Cloudinary::Uploader.destroy("rails_test_project/#{uri[uri.size - 1].split('.', -1)[0]}")
  end

  def self.batch_destroy(attachments)
    attachments.each do |file|
      uri = file.uri.split('/', -1)
      Cloudinary::Uploader.destroy("rails_test_project/#{uri[uri.size - 1].split('.', -1)[0]}")
      file.destroy
    end
  end
end
