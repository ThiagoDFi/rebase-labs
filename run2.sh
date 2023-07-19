docker run \
  --rm \
  --name postgres \
  --network rebase-lab \
  -e POSTGRES_PASSWORD=password \
  -p 5432:5432 \
  -v /home/thiagofirmino/Documentos/treinadev/rebase-labs/saves:/var/lib/postgresql/data \
  -d \
  postgres