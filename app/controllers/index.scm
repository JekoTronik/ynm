;; Controller index definition of mealadvisor
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller index) ; DO NOT REMOVE THIS LINE!!!

(get "/"
     (lambda ()
       (tpl->response "app/views/index/index.html.tpl")))
