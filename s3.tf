resource "aws_s3_bucket" "my_bucket" {
  bucket = "hb-terraform-101"

  tags = {
    Name = "hb-terraform-101"
  }
}