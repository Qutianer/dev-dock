build.target: Dockerfile *.conf
	docker build -t nginx-a -t localhost:5000/nginx-a .
	docker push localhost:5000/nginx-a
	touch build.target

clean:
	rm -rf build.target
	docker image rm -f nginx-a localhost:5000/nginx-a
