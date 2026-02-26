locals {
  web_ips   = yandex_compute_instance.web[*].network_interface.0.nat_ip_address
  web_fqdns = yandex_compute_instance.web[*].fqdn

  databases_ips = {
    for name, db in yandex_compute_instance.databases : name => db.network_interface.0.nat_ip_address
  }
  databases_fqdns = {
    for name, db in yandex_compute_instance.databases : name => db.fqdn
  }

  storage_ip   = yandex_compute_instance.storage.network_interface.0.nat_ip_address
  storage_fqdn = yandex_compute_instance.storage.fqdn
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tmpl",
    {
      web_ips         = local.web_ips
      web_fqdns       = local.web_fqdns
      databases       = var.each_vm
      databases_ips   = local.databases_ips
      databases_fqdns = local.databases_fqdns
      
      storage_ip      = local.storage_ip
      storage_fqdn    = local.storage_fqdn
    }
  )
  filename = "${path.module}/hosts.cfg"
}