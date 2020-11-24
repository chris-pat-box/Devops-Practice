variable "region" {
  default = "ap-southeast-1"
}
variable "ami_id" {
  default = {
    ap-southeast-1 = "ami-03faaf9cde2b38e9f"
	ap-southeast-2 = "ami-076e39b6b14e3bb20"
	ap-south-1 = "ami-026669ec456129a70"
  }
}
variable "instance_type" {
  default = "t2.micro"
}
variable "web-server-port" {
  #description = "this is port that serves HTTP requests"
  default = 22
}