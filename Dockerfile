FROM python:3.12.3-alpine3.19
LABEL mantainer="lucas.ta@outlook.com"

# Controla se o Python deve gravar arquivos de bytecode (.pyc) no disco.
# 1 = não, 0 = sim
ENV PYTHONDONTWRITEBYTECODE 1

# Outputs do Python em tempo real, saída no console ou em outros
# dispositivos de saída
ENV PYTHONUNBUFFERED 1

# Copia a pasta "djangoapp" e "scripts" para dentro do container.
COPY djangoapp /djangoapp
# A pasta scripts comporta scripts que podem ser executados dentro do container.
COPY scripts /scripts

# Entra na pasta djangoapp no container
WORKDIR /djangoapp

# Expõe a porta 8000 para conexões externas ao container.
EXPOSE 8000

# Executa comandos em um shell dentro do container para construir
# a imagem. O resultado da execução do comando é armazenado no sistema
# de arquivos da imagem como uma nova camada.
# Agrupar os comandos em um único RUN pode reduzir a quantidade
# de camadas da imagem e torná-la mais eficiente.
RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /djangoapp/requirements.txt && \
    adduser --disabled-password --no-create-home duser && \
    mkdir -p /data/web/static && \
    mkdir -p /data/web/media && \
    chown -R duser:duser /venv && \
    chown -R duser:duser /data/web/static && \
    chown -R duser:duser /data/web/media && \
    chmod -R 755 /data/web/static && \
    chmod -R 755 /data/web/media && \
    chmod -R +x /scripts

# Adiciona scripts e venv/bin no $PATH do container.
ENV PATH="/scripts:/venv/bin:$PATH"

# Altera o usuário para duser
USER duser

# Executa o arquivo scripts/commands.sh
CMD ["commands.sh"]
