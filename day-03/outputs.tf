output "Ip-address-from-instance" {
    value = module.ec2_instance.public-ip-address
}