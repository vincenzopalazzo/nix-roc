CC=roc
FMT=fmt

ARGS=

default: fmt
	$(CC) check main.roc
	$(CC) build main.roc

fmt:
	$(CC) format .

check: default
	$(CC) test

clean:
	$(CC) clean