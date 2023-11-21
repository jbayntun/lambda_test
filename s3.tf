provider "aws" {
  region  = "us-east-1"
}

resource "aws_s3_bucket" "image_bucket" {
  bucket = "my-image-bucket-ghrty-8765"
  acl    = "private"

  versioning {
    enabled = true 
  }
}

resource "aws_s3_bucket_object" "original_images_folder" {
  bucket = aws_s3_bucket.image_bucket.bucket
  key    = "original/"
  acl    = "private"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "resized_images_folder" {
  bucket = aws_s3_bucket.image_bucket.bucket
  key    = "resized/"
  acl    = "private"
  source = "/dev/null"
}

output "bucket_name" {
  value = aws_s3_bucket.image_bucket.bucket
  description = "The name of the created bucket"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.image_bucket.bucket
  
  lambda_function {
    lambda_function_arn = aws_lambda_function.image_resizer.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "original/"
  }
}


