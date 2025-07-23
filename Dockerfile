FROM codercom/code-server:latest

# Không dùng mật khẩu
ENV PASSWORD=""
ENV AUTH=none

EXPOSE 8080

CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
