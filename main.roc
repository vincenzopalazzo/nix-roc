app "roc template application"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.8.1/x8URkvfyi9I0QhmVG98roKBUs_AZRkLFwFJVJ3942YA.tar.br" }
    imports [pf.Stdout, pf.Task.{ Task }]
    provides [main] to pf

main : Task {} I32
main =
    Stdout.line "Hello, World!"

expect
    Bool.true
