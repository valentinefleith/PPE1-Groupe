def escape_html(code):
    return (code.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace('"', "&quot;")
                .replace("'", "&apos;"))

with open("../programmes/make_itrameur_corpus.sh", "r") as code:
    programme = code.read()
script_bash_echappe = escape_html(programme)
with open("script_echappe_itrameur.sh", "w") as echappe:
    echappe.write(script_bash_echappe)
