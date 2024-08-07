variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 22
}
