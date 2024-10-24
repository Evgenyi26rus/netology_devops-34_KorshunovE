locals {
  vms_ssh_root_key = "${"ubuntu"}:${file("~/.ssh/1.pub")}"
  vms_ssh_private_key = "${"ubuntu"}:${file("~/.ssh/1")}"
}

