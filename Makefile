postgrescreate:
	sudo docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -d postgres

createdb:
	sudo docker exec -it postgres createdb --username=root --owner=root simple_bank

dropdb:
	sudo docker exec -it postgres dropdb simple_bank

sqlc:
	sqlc generate

postgresstart:
	sudo docker start postgres

postgresstop:
	sudo docker stop postgres

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/Pablo-E/simple-bank-go/db/sqlc Store