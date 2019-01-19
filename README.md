# docker-riscv-qemu

## How to use 
- qemuを起動

```
$ docker run -d -p 1234:10000 tsunetsune/docker-riscv-qemu-fedora:0.1
```

- sshでログイン (マシンのスペックにもよるが、起動までに1分程度時間がかかるので、少し待ってからssh)

```
$ ssh -p 1234 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost
```
