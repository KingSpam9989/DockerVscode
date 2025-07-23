FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Cài các gói cần thiết
RUN apt update && apt install -y \
    curl wget sudo git zsh vim python3 python3-pip net-tools htop tmux unzip nano \
    && apt clean

# Tạo user vscode có quyền sudo
RUN useradd -m vscode && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Cài code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Cấu hình code-server
RUN mkdir -p /home/vscode/.config/code-server
COPY --chown=vscode:vscode config.yaml /home/vscode/.config/code-server/config.yaml

EXPOSE 8080

# Chạy với user vscode
USER vscode
WORKDIR /home/vscode

CMD ["code-server"]
