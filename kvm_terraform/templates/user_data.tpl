#cloud-config
hostname: ${hostname}
manage_etc_hosts: true
ssh_pwauth: True
chpasswd:
  list: |
     root: senhaForte
  expire: False
users:
  - default
  - name: suporte
    gecos: Suporte
    primary_group: suporte
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCeLRfOtHYsWVXbkU/3+7VUE5J024YS6fTAkzAaFuwWlln9za5EQ4kzoSJmcsY+53WsLJZY7VUG4vNQiHvGh4Qb5mmQm+oj1Unr2eZ8rqTfCwgO8NWeQfSjAveB9IDGENXhKvB/OgG9MtGXFdvMaDs0scfa/0k6q08UgL35yG/F++LU5vW/jUzuIWaH9S92rnwR8/mMToEnS1Yc9XZlVCaxU3IKzdeQZO45dYWLfkHL7mQwFMK8xAtTqzwKt/fnmX17EHvTyMtVYZC8HR5V41IXMTBuhBaFDupE5tNcQzM46o5dabR/dWIReejYoL3Dm28ZVUcE6jsgqG+2bvBvzKD0E1EuQg9/OHTyNDmM3qafFZsOx1SqGoBP2JR5laYbCSB1WEyfXuc4+rHV7k+2nTcHNAQFYIwhsxKKPxTuxvAgJv8Qoz7bbHHLlfoEpAn5fDth+2s/yobDTB+pO4J1Bd8YY7xMS0ZMX2fJLf5j9HCe5safKFszOpMMIF3zGAkUWMk= ekarani@laptop-ekarani
    lock_passwd: false
    passwd: senhaForte
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    shell: /bin/bash
    groups: wheel

