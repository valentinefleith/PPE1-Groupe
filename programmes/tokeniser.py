import thulac

thul = thulac.thulac(seg_only = True)

thul.cut_f("../itrameur/contextes-zh.txt", "../itrameur/tokenized-contextes.txt")

thul.cut_f("../itrameur/dump-texts-zh.txt", "../itrameur/tokenized-dump.txt")