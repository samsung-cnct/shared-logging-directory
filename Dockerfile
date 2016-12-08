FROM busybox

ADD directory-prep.sh /

ENTRYPOINT ["/directory-prep.sh"]