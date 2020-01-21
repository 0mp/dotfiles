entr_LIST_CMD=	find
# entr_LIST_CMD=	printf "%s\n"
entr_FILE_LIST=	.
entr_LIST=	${entr_LIST_CMD} ${entr_FILE_LIST}

entr_ENTR=	entr -c -d -s

entr_UTIL=	"echo change /_"

entr: .PHONY
	while :; do ${entr_LIST} | ${entr_ENTR} ${entr_UTIL} || [ $$? -eq 0 ] && break; done
