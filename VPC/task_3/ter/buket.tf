resource "yandex_storage_bucket" "bucket_image" {
    bucket = "ioan290725"
    folder_id = var.folder_id
    max_size = 524288000
    anonymous_access_flags {
      read = true
      list = true
      config_read = true
    }
    server_side_encryption_configuration {
   rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-monkey.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}


resource "yandex_storage_object" "monkey" {
  content_type = "image/jpeg"
  depends_on = [ yandex_storage_bucket.bucket_image ]
  bucket = "ioan290725"
  key = "monkfey.jpg"
  source = "~/Downloads/photo_2025-07-28_14-14-28.jpg"
  acl="public-read"
  
}
