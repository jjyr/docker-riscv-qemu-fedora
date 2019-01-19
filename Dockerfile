FROM ubuntu:18.04

RUN apt update
RUN apt install -y git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev wget python

RUN wget https://download.qemu.org/qemu-3.1.0.tar.xz
RUN tar Jxf qemu-3.1.0.tar.xz
RUN cd qemu-3.1.0 && ./configure --target-list=riscv64-softmmu && make && make install

RUN wget http://fedora-riscv.tranquillity.se/kojifiles/work/tasks/5629/155629/Fedora-Developer-Rawhide-20190112.n.0-sda.raw.xz
RUN wget https://fedorapeople.org/groups/risc-v/disk-images/bbl
RUN unxz Fedora-Developer-Rawhide-20190112.n.0-sda.raw.xz

EXPOSE 10000
CMD qemu-system-riscv64 -nographic -machine virt -smp 4 -m 2G -kernel bbl -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-device,rng=rng0 -append "console=ttyS0 ro root=/dev/vda1" -device virtio-blk-device,drive=hd0 -drive file=Fedora-Developer-Rawhide-20190112.n.0-sda.raw,format=raw,id=hd0 -device virtio-net-device,netdev=usernet -netdev user,id=usernet,hostfwd=tcp::10000-:22
