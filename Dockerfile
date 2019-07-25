FROM ubuntu:18.04

RUN apt update --fix-missing && \
  apt update && \
  apt install -y git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev wget python && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

RUN wget https://download.qemu.org/qemu-3.1.0.tar.xz && \
  tar Jxf qemu-3.1.0.tar.xz && \
  cd qemu-3.1.0 && ./configure --target-list=riscv64-softmmu && \
  make && make install && \
  rm -rf qemu-3.1.0.tar.xz qemu-3.1.0

RUN wget https://dl.fedoraproject.org/pub/alt/risc-v/disk-images/fedora/rawhide/20190703.n.0/Developer/Fedora-Developer-Rawhide-20190703.n.0-sda.raw.xz && \
  wget https://fedorapeople.org/groups/risc-v/disk-images/bbl && \
  unxz Fedora-Developer-Rawhide-20190112.n.0-sda.raw.xz

EXPOSE 10000

CMD qemu-system-riscv64 -nographic -machine virt -smp 4 -m 2G -kernel bbl -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-device,rng=rng0 -append "console=ttyS0 ro root=/dev/vda1" -device virtio-blk-device,drive=hd0 -drive file=Fedora-Developer-Rawhide-20190112.n.0-sda.raw,format=raw,id=hd0 -device virtio-net-device,netdev=usernet -netdev user,id=usernet,hostfwd=tcp::10000-:22

