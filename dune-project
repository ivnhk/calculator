(lang dune 3.17)

(name calculator)

(generate_opam_files true)

(source
 (github ivnhk/calculator))

(authors "Ivan Hrekov <iandrc9@gmail.com>")

(maintainers "Ivan Hrekov <iandrc9@gmail.com>")

(license MIT)

(documentation https://github.com/ivnhk/calculator)

(package
 (name calculator)
 (synopsis "A simple calculator from CS3110")
 (description "A simple calculator from CS3110 implemented using OCaml and Menhir")
 (depends ocaml menhir)
 (tags
  ("calculator" "interpreter" "parser")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
