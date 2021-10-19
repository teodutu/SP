DIR = keys
CA = ca
CFG = openssl.conf
CLIENT = client
CLIENT_PKCS12 = client2
SERVER = server
CN = teo

ca:
	./create_ca.sh $(DIR) $(CA) $(CFG) $(CN)

server:
	./create_server_cert.sh $(DIR) $(SERVER) $(CFG) $(CN)

client:
	./create_client_cert.sh $(DIR) $(CLIENT) $(CFG) $(CN)

client_pkcs12:
	./create_pkcs12.sh $(DIR) $(CLIENT_PKCS12) $(CA) $(CFG) $(CN)

revoke:
	./revoke_cert.sh $(DIR) $(CLIENT) $(CFG)

test_revoke: revoke
	./test_revoke.sh $(DIR) $(CLIENT) $(CA)

clean:
	rm -rf $(DIR) .rnd
