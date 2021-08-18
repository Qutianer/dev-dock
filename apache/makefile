build.target: Dockerfile *.conf
	docker build -t httpd-a -t localhost:5000/httpd-a .
	docker push localhost:5000/nginx-a
	touch build.target

clean:
	rm -rf build.target
	docker image rm -f httpd-a localhost:5000/httpd-a
