#lang racket

;; This module exports all common HTML tags
;; as strings with bindings set to their respective
;; tag names. e.g
;; (define p "p")
;; (define div "div")

(require (for-syntax racket/syntax
                     syntax/stx
                     syntax/parse))

(provide (all-defined-out))

;; A macro to bind a string representation of an indefinite
;; number of provided symbols to themselves
;; ex: (bind-strings-to-self p div)
;; -> (define p "p")
;; -> (define div "div")
(define-syntax (bind-strings-to-self stx)
  (syntax-parse stx
   [(_ ())
    #'(void)]
   [(_ (curr-str other-strs ...))
    (with-syntax ([curr-var (format-id #'curr-str "~a" (syntax->datum #'curr-str))])
        #'(begin
            (define curr-var curr-str)
            (bind-strings-to-self (other-strs ...))
        ))]))

(bind-strings-to-self ("a" "abbr" "acronym" "address" "applet" "area" "article" "aside" "audio" "b" "base" "basefont" "bdi" "bdo" "big" "blockquote" "body" "br" "button" "canvas" "caption" "center" "cite" "code" "col" "colgroup" "data" "datalist" "dd" "del" "details" "dfn" "dialog" "dir" "div" "dl" "dt" "em" "embed" "fieldset" "figcaption" "figure" "font" "footer" "form" "frame" "frameset" "h1" "h2" "h3" "h4" "h5" "h6" "head" "header" "hgroup" "hr" "html" "i" "iframe" "img" "input" "ins" "kbd" "label" "legend" "li" "link" "main" "map" "mark" "meta" "meter" "nav" "noframes" "noscript" "object" "ol" "optgroup" "option" "output" "p" "param" "picture" "pre" "progress" "q" "rp" "rt" "ruby" "s" "samp" "script" "section" "select" "small" "source" "span" "strike" "strong" "style" "sub" "summary" "sup" "table" "tbody" "td" "template" "textarea" "tfoot" "th" "thead" "time" "title" "tr" "track" "tt" "u" "ul" "var" "video" "wbr"))

;; ;; test case
;; (define-symbols-as-strings "p" "div" "h1" "h2")
;; (displayln p) ;; "p"
;; (displayln div) ;; "div"