build: ## Build docker image
	docker-compose build

start:build
	docker-compose up --force-recreate

stop: 
	docker-compose stop

rebuild: # run jekyll build inside container to update on the go
	docker-compose exec jekyll jekyll build --incremental --watch
