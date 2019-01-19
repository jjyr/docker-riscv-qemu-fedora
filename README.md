# docker-riscv-qemu

## How to use 
- qemuを起動

```
$ docker pull tsunetsune/docker-riscv-qemu-fedora:0.1 -t 
$ docker run -d -p 1234:10000 -t docker-riscv-qemu-fedora:0.1
```

- sshでログイン

```
$ ssh -p 1234 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost
```