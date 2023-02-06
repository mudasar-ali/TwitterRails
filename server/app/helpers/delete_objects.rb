def delete_objects_from_s3(obj)
  s3 = Fog::Storage.new(
        provider: 'AWS',
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region: "ap-northeast-1",
      )
  bucket = s3.directories.get(ENV['S3_BUCKET'])
  bucket.files.get("uploads/myphotos/#{obj}").destroy
  bucket.files.get("uploads/myphotos/thumbnail_#{obj}").destroy
end
