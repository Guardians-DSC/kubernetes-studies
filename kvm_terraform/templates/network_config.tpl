ethernets:
    ${interface}:
        addresses:
        - ${net_addr}/${net_gateway}
        dhcp4: true
        gateway4: ${net_gateway}
version: 2 

