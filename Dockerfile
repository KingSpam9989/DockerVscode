FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Cài các gói cơ bản
RUN apt update && apt install -y \
    curl wget sudo git zsh vim python3 python3-pip net-tools htop tmux unzip nano \
    && apt clean

# Đặt mật khẩu root để su (tùy chọn)
RUN echo "root:rootpass" | chpasswd

# Tạo user vscode và cấp quyền sudo không cần mật khẩu
RUN useradd -m -s /bin/bash vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Cài đặt code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Cấu hình code-server
USER vscode
RUN mkdir -p /home/vscode/.config/code-server
COPY --chown=vscode:vscode config.yaml /home/vscode/.config/code-server/config.yaml

# Làm thư mục làm việc mặc định
WORKDIR /home/vscode

EXPOSE 8080

# Khởi động code-server
CMD ["code-server"]
