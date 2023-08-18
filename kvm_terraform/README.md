# Provisionamento de KVM com Terraform
Queremos um cenário de cluster K8s onde cada nó do cluster é uma máquina virtual. Usaremos KVM.

Esse cenário poderia ser gerado com outros tipos de máquinas virtuais, OpenStack, AWS, por meio de Virtual Box ou VMWare etc. Todavia, é válido o estudo do provisionamento desse tipo de máquina virtual, cujo provedor é o próprio sistema operacional Linux de qualquer máquina com hardware compatível.

# Preparando Ambiente (Requisitos do Sistema)
É desejável uma distribuição Linux compatível com os seguintes pacotes:
- QEMU
- Libvirt
- Terraform

E configurações de hardware que possibilitem a criação de VMs com 2 GB de RAM e 2 vCPUs cada.

## Instalando Terraform
Instale o Terraform executando os comandos abaixo:
```
sudo su || su -
apt update
apt install unzip -y
wget https://releases.hashicorp.com/terraform/1.0.9/terraform_1.0.9_linux_amd64.zip
unzip terraform_1.0.9_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform version
```
## Pacotes para a virtualização
```
sudo apt install qemu-kvm -y
sudo apt install libvirt-daemon-system -y
sudo apt install virtinst -y
sudo apt install libvirt-clients -y
sudo apt install bridge-utils -y
sudo apt install mkisofs -y
```
## Atualizando permissões de virtualização
Provavelmente todas as linhas do arquivo de configuração do QEMU estarão comentadas. É preciso retirar o comentário da linha `security_driver = "none"`
```
sudo vim /etc/libvirt/qemu.conf
```

Deve ficar assim:
```
(...)
# The default security driver is SELinux. If SELinux is disabled
# on the host, then the security driver will automatically disable
# itself. If you wish to disable QEMU SELinux security driver while
# leaving SELinux enabled for the host in general, then set this
# to 'none' instead. It's also possible to use more than one security
# driver at the same time, for this use a list of names separated by
# comma and delimited by square brackets. For example:
#
       security_driver = "none"
#
# Notes: The DAC security driver is always enabled; as a result, the
# value of security_driver cannot contain "dac".  The value "none" is
# a special value; security_driver can be set to that value in
# isolation, but it cannot appear in a list of drivers.
(...)
```
## Sobre Terraform
O Terraform é uma ferramenta open-source de Infrastructure as Code (IAC) que possibilita a criação, mudança e melhoramento de infraestrutura. Com ela, é possível provisionar infraestrutura com códigos em linguagem declarativa e de fácil compreensão.

Terraform cria e gerencia recursos em diversos serviços e plataformas por meio de sua API. É com essa API e providers que é possível que Terraform interaja com quase qualquer plataforma ou serviço com API acessível.
### Conceitos importantes
- **Variáveis (variables)**: pares chave-valor
- **Provider**: plugin que interage com APIs de serviços e seus recursos
- **Module**: Diretório com templates Terraform contendo configurações definidas
- **State**: Consiste em informação em cache sobre a infraestrutura gerenciada por Terraform
- **Resources**: "Infrastructure objects" (por exemplo: redes virtuais, instâncias de compute) que são usados na configuração e gerenciamento da infraestrutura.

### Lifecycle
1. `terraform init`

    Inicializa o diretório onde estão os arquivos de configuração. Havendo já definidos os providers nos arquivos .tf, o comando se encarrega de clonar as configurações necessárias para fazer uso dos resources referenciados pelos providers
    
2. `terraform plan`

    Pode ser opcional, mas é útil para criar o plano de execução que leve ao estado final desejado na infraestrutura. Ele aponta se está tudo certo nos arquivos de configuração antes de rodar.

3. `terraform apply`

    Implementa as modificações na infraestrutura especificadas nos arquivos de configuração.

4. `terraform destroy`

    É usado para deletar todos os recursos de infraesrtutura existentes, incluse para desfazer o que foi feito com o apply.

Para mais (e melhores) detalhes sobre Terraform para além do básico: [Learn Terraform: The Ultimate Terraform Tutorial](https://automateinfra.com/2022/01/14/learn-terraform-the-ultimate-terraform-tutorial-part-1/#what-is-terraform)

## Sobre Libvirt

# Procedimento de Provisionamento
*Realize os comandos em sudo*
1. Crie os diretórios a seguir:
```
mkdir /tfdata
mkdir /tfdata/ubuntu-core
mkdir /tfdata/pool
mkdir /tfdata/backups
```
2. Modifique os arquivos `./templates/cloud_init.cfg`, `./templates/user_data.tpl` e `variables.tf` adicionando sua chave ssh pública:
- `./templates/cloud_init.cfg` e `./templates/user_data.tpl`
```
(...)
	ssh_authorized_keys:
      		- ssh-rsa AAAAB3 ...
	lock_passwd: false
(...)
```
- `variables.tf`
```
(...)
variable "ssh_key" {
    type    = string
    default = "ssh-rsa AAAAB3NzaC1yc...
}
(...)
```
3. Inicialize o diretório
```
terraform init
```
4. Implemente o script terraform
```
terraform apply
```
5. Obtenha os IPs das máquinas virtuais criadas
```
sudo virsh net-dhcp-leases default
```
Com esses IPs será possível acessar as máquinas virtuais via ssh com a chave privada correspondente à pública passada no script terraform



# Referências
- [Repositório Climatica VM Setup](https://github.com/igorkso/climatica-vm-setup)
  
*Agradecimentos a Igor do Suporte do LSD*

