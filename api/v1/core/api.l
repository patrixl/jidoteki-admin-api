# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2015 Alexander Williams, Unscramble <license@unscramble.jp>

(load "@lib/http.l")

(setq
  *PR_SET_NAME    15
  *JIDO_API_PORT  (if (format (sys "JIDO_API_PORT")) @ 8080) )

[de https-start ()
  (when (sys "JIDO_WITH_SSL")
    (if (sys "JIDO_STUNNEL_BIN")
        (call @ "stunnel.conf")
        (call '/usr/bin/stunnel4 "stunnel.conf") ]

[de https-stop ()
  (when (sys "JIDO_WITH_SSL")
    (if (sys "JIDO_STUNNEL_BIN")
        (call 'killall @)
        (call 'killall "stunnel4") ]

[de api-start ()
  (finally
    (api-stop)
    (https-start)
    (prinl "HTTP listening on port: " *JIDO_API_PORT)
    (server *JIDO_API_PORT "index.html") ]

(de api-stop ()
  (https-stop) )
