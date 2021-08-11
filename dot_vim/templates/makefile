entr_LIST_CMD=	find
# entr_LIST_CMD=	printf "%s\n"
entr_FILE_LIST=	.
entr_LIST=	${entr_LIST_CMD} ${entr_FILE_LIST}

entr_ENTR=	entr -c -d -s

entr_UTIL=	"echo 'changed $$0'" /_

.PHONY: entr
entr:
	while :; do \
		${entr_LIST} | ${entr_ENTR} ${entr_UTIL} && break; \
	done
