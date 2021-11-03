#include <openssl/ssl.h>
#include <openssl/bio.h>
#include <openssl/err.h>

#include "stdio.h"
#include "string.h"

int main()
{
    BIO *bio;
    SSL *ssl;
    SSL_CTX *ctx;
    FILE *fp;

    int ret;

    char *request = "GET / HTTP/1.0\r\nHost: www.verisign.com\r\n\r\n";
    char r[1024];

    fp = fopen("verisign.html", "w");

    /* Init library */  
    SSL_library_init ();
    ERR_load_BIO_strings();
    SSL_load_error_strings();
    OpenSSL_add_all_algorithms();

    /* TO DO context init */
    ctx = SSL_CTX_new(SSLv23_client_method());
   

    /* load trust store */
    if(! SSL_CTX_load_verify_locations(ctx, "TrustStore.pem", NULL)) {
        fprintf(stderr, "Error loading trust store\n");
        goto exit_err;
    }


    /* establish connection */
    bio = BIO_new_ssl_connect(ctx);
   
    /* Set SSL_MODE_AUTO_RETRY flag */
    BIO_get_ssl(bio, & ssl);
    SSL_set_mode(ssl, SSL_MODE_AUTO_RETRY);

    /* TO DO setup connection */
    BIO_set_conn_hostname(bio, "verisign.com:443");

    /* check the connection and do the handshake */
    if (BIO_do_connect(bio) <= 0) {
        fprintf(stderr, "Error performing the handshake\n");
        goto exit_err;
    }

    /* TO DO check certificate */
    if (SSL_get_verify_result(ssl) != X509_V_OK) {
        fprintf(stderr, "SSL validation failed\n");
        goto exit_err;
    }

    /* Send request */
    BIO_write(bio, request, strlen(request));

    /* TO DO read answer and prepare output*/
    do {
        ret = BIO_read(bio, r, sizeof(r));
        if (!ret)
            break;
        else if(ret < 0) {
            if(!BIO_should_retry(bio))
                fprintf(stderr, "Read failure\n");
            else
                fprintf(stderr, "Failed retry operation\n");

            goto exit_err;
        } else
            fwrite(r, sizeof(*r), ret, fp);
    } while (1);

    /* Close the connection and free the context */
    printf("Everything is ok\n");

    goto exit;

exit_err:   
    ERR_print_errors_fp(stderr);

exit:
    fclose(fp);
    BIO_free_all(bio);
    SSL_CTX_free(ctx);
    return 0;
}
