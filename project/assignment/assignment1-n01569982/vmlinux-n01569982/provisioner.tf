# resource "null_resource" "display_hostnames" {
#   count      = var.vm_count
#   depends_on = [azurerm_linux_virtual_machine.vm-linux]
#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "akash"
#       private_key = file("${var.vmlinux_priv_key_path}")
#       host        = azurerm_public_ip.linux-ip[count.index].fqdn
#     }
#     inline = [
#       "echo 'The hostname is:' $(hostname)"
#     ]
#   }
# }

resource "null_resource" "ansible_provisioner" {
  # count      = var.vm_count
  depends_on = [azurerm_linux_virtual_machine.vm-linux]

  provisioner "local-exec" {
    command = "ansible-playbook -i ~/automation/project/ansible/hosts ~/automation/project/ansible/n01569982-playbook.yaml"
  }
}
