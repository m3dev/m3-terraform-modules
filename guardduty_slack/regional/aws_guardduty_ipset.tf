resource "aws_guardduty_ipset" "MyIPSet" {
  provider = "aws.regional"

  activate = true
  detector_id = "${aws_guardduty_detector.main.id}"
  format = "TXT"
  location = "${var.ipset_location}"
  name = "terraform managed trusted IP set ${count.index}"
}
