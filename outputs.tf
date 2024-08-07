# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "domain-name" {
  value = aws_instance.example.public_dns
}

output "application-url" {
  value = "${aws_instance.example.public_dns}/index.html"
}
