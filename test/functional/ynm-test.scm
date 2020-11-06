(define-module (ynm test unit))

(use-modules (srfi srfi-64)
	     (artanis artanis)
	     (web client)
	     (ice-9 receive))

(module-define! (resolve-module '(srfi srfi-64))
		'test-log-to-file #t)


(define SERVER_DEFAULT_PORT "3000")
(define SERVER_LOCAL_ADDRESS "127.0.0.1:")
(define INDEX_ROUTE "/")

(define (wait-for seconds)
  (let wait ([time-ref (current-time)])
    (if (< (- (current-time) time-ref) seconds)
	(wait time-ref))))

(define (wait-for-server-to-be-ready)
  (let ([ONE_SECOND 1])
    (wait-for ONE_SECOND)))

(define (response-body URI)
  (receive (response body)
      (http-request URI)
    body))

(test-begin "webapp")

(define (start-server)
  (system "art work &" )
  (wait-for-server-to-be-ready))

(define (stop-server)
  (system* "killall" ".art-real"))

(test-group-with-cleanup INDEX_ROUTE
  
  (start-server)
  (test-assert "best title of the world"
    (string-contains (response-body (string-append "http://" SERVER_LOCAL_ADDRESS SERVER_DEFAULT_PORT INDEX_ROUTE))
		     "<title>YNM! &ndash; Your Next Meal !</title>"))
  (stop-server))

(test-end "webapp")
