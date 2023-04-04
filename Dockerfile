FROM python:3.9

ENV PORT=8080

USER root

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir /data && mkdir /data/myGPTReader

EXPOSE 8080

CMD if [ -n "$SWAP" ]; then fallocate -l $(($(stat -f -c "(%a*%s/10)*7" .))) _swapfile && mkswap _swapfile && swapon _swapfile && ls -hla; fi; free -m; gunicorn app.server:app
