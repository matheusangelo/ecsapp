output "subnet_name" {
  value = aws_subnet.public_subnet[0].tags["Name"]
}

output "security_group_name" {
  value = aws_security_group.app.name
}