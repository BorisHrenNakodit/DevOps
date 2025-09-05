resource "local_file" "hosts" {
  depends_on = [ yandex_compute_instance.vms ]
  filename = "/home/Ioan/Git_repository/DevOps/Diplom/ansible-kub/kubespray/inventory/mycluster/inventory.yaml"

  content = templatefile("./hosts.tftpl",
  { vms = yandex_compute_instance.vms})
}