variable "x" {
	type = string
	default = "Linux World"
}

output "myvalue" {
	value = "${var.x}"
}
