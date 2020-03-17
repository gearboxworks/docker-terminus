#!/bin/bash
# Created on 2020-03-17T12:27:12+1100, using template:01-base.sh.tmpl and json:gearbox.json

p_info "terminus" "test started."

TERMINUS="$(which terminus)"
if [ "${TERMINUS}" != "" ]
then
	c_ok "Terminus found."
else
	c_err "Terminus NOT found."
fi

if ${TERMINUS} --version
then
	c_ok "Terminus version OK."
else
	c_err "Terminus version NOT OK."
fi

if ${TERMINUS} auth:whoami
then
	c_ok "Terminus whoami OK."
else
	c_err "Terminus whoami NOT OK."
fi

p_info "terminus" "test finished."

