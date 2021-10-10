LDLIBS=-lssl -lcrypto
CERT=certreq

.PHONY: build, run, clean

build: $(CERT)

run: $(CERT)
	./$<

clean:
	rm -f $(CERT) *.crt *.pem
