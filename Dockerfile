FROM ubuntu:18.04

RUN apt update --fix-missing && \
  apt update && \
  apt install -y git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev wget python && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

RUN wget https://download.qemu.org/qemu-4.0.0.tar.xz && \
  tar Jxf qemu-4.0.0.tar.xz && \
  cd qemu-4.0.0 && ./configure --target-list=riscv64-softmmu && \
  make && make install && \
  rm -rf qemu-4.0.0.tar.xz qemu-4.0.0

RUN wget https://dl.fedoraproject.org/pub/alt/risc-v/disk-images/fedora/rawhide/20190703.n.0/Developer/Fedora-Developer-Rawhide-20190703.n.0-sda.raw.xz && \
  wget https://dl.fedoraproject.org/pub/alt/risc-v/disk-images/fedora/rawhide/20190703.n.0/Developer/fw_payload-uboot-qemu-virt-smode.elf && \
  unxz Fedora-Developer-Rawhide-20190703.n.0-sda.raw.xz

EXPOSE 10000

CMD qemu-system-riscv64 -nographic -machine virt -smp 4 -m 2G -kernel fw_payload-uboot-qemu-virt-smode.elf -device virtio-blk-device,drive=hd0 -drive file=Fedora-Developer-Rawhide-20190703.n.0-sda.raw,format=raw,id=hd0 -device virtio-net-device,netdev=usernet -netdev user,id=usernet,hostfwd=tcp::10000-:22
