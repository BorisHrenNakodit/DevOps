resource "yandex_storage_bucket" "bucket_image" {
    bucket = "ioan290725"
    folder_id = var.folder_id
    max_size = 524288000
    anonymous_access_flags {
      read = true
      list = true
      config_read = true
    }
    
    # website {
    #   index_document = "index.html"
    #   error_document = "error.html"
    # }
    # cors_rule {
    #   allowed_headers = [ "*" ]
    #   allowed_methods = ["GET","HEAD"]
    #   allowed_origins = ["*"]
    #   expose_headers = ["ETag"]
    #   max_age_seconds = 3000
    # }
}
resource "yandex_storage_object" "monkey" {
  content_type = "image/jpeg"
  depends_on = [ yandex_storage_bucket.bucket_image ]
  bucket = "ioan290725"
  key = "monkey.jpg"
  source = "~/Downloads/photo_2025-07-28_14-14-28.jpg"
  acl="public-read"
}
