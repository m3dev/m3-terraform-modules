resource "aws_guardduty_ipset" "MyIPSet" {
  count    = var.is_enable_guardduty_ipset == true ? 1 : 0
  provider = aws.regional

  activate    = true
  detector_id = aws_guardduty_detector.main.id
  format      = "TXT"
  location    = var.ipset_location
  name        = "terraform-${random_id.hash[0].hex}"
}

resource "random_id" "hash" {
  count = var.is_enable_guardduty_ipset == true ? 1 : 0

  keepers = {
    # Generate a new id each time we switch to a new AMI id
    ipset_location = var.ipset_location
  }

  byte_length = 8
}

