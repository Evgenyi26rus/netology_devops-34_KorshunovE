resource "local_file" "ansible_inventory" {
  filename = "${abspath(path.module)}/ansible.cfg"
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.platform,
    databases = yandex_compute_instance.for_each,
    storage = yandex_compute_instance.storage_vm,
  })
}

resource "null_resource" "web_hosts_provision" {
depends_on = [yandex_compute_instance.platform, yandex_compute_instance.for_each, yandex_compute_instance.storage_vm]

provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "local-exec" {
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
    triggers = {
      always_run         = "${timestamp()}"
      playbook_src_hash  = file("${abspath(path.module)}/test.yml")
      ssh_public_key     = local.vms_ssh_root_key
    }

}