#! /bin/sh -

augenpolizei="$(cat << 'EOF'
                                ,_-=(!7(7/zs_.                                       ,_-=(!7(7/zs_.
                             .='  ' .`/,/!(=)Zm.                                  .='  ' .`/,/!(=)Zm.
               .._,,._..  ,-`- `,\ ` -` -`\\7//WW.                  .._,,._..  ,-`- `,\ ` -` -`\\7//WW.
          ,v=~/.-,-\- -!|V-s.)iT-|s|\-.'   `///mK%.            ,v=~/.-,-\- -!|V-s.)iT-|s|\-.'   `///mK%.
        v!`i!-.e]-g`bT/i(/[=.Z/m)K(YNYi..   /-]i44M.         v!`i!-.e]-g`bT/i(/[=.Z/m)K(YNYi..   /-]i44M.
      v`/,`|v]-DvLcfZ/eV/iDLN\D/ZK@%8W[Z..   `/d!Z8m       v`/,`|v]-DvLcfZ/eV/iDLN\D/ZK@%8W[Z..   `/d!Z8m
     //,c\(2(X/NYNY8]ZZ/bZd\()/\7WY%WKKW)   -'|(][%4.     //,c\(2(X/NYNY8]ZZ/bZd\()/\7WY%WKKW)   -'|(][%4.
   ,\\i\c(e)WX@WKKZKDKWMZ8(b5/ZK8]Z7%ffVM,   -.Y!bNMi   ,\\i\c(e)WX@WKKZKDKWMZ8(b5/ZK8]Z7%ffVM,   -.Y!bNMi
   /-iit5N)KWG%%8%%%%W8%ZWM(8YZvD)XN(@.  [   \]!/GXW[   /-iit5N)KWG%%8%%%%W8%ZWM(8YZvD)XN(@.  [   \]!/GXW[
  / ))G8\NMN%W%%%%%%%%%%8KK@WZKYK*ZG5KMi,-   vi[NZGM[  / ))G8\NMN%W%%%%%%%%%%8KK@WZKYK*ZG5KMi,-   vi[NZGM[
 i\!(44Y8K%8%%%**~YZYZ@%%%%%4KWZ/PKN)ZDZ7   c=//WZK%! i\!(44Y8K%8%%%**~YZYZ@%%%%%4KWZ/PKN)ZDZ7   c=//WZK%!
,\v\YtMZW8W%%f`,`.t/bNZZK%%W%%ZXb*K(K5DZ   -c\\/KM48 ,\v\YtMZW8W%%f`,`.t/bNZZK%%W%%ZXb*K(K5DZ   -c\\/KM48
-|c5PbM4DDW%f  v./c\[tMY8W%PMW%D@KW)Gbf   -/(=ZZKM8[ -|c5PbM4DDW%f  v./c\[tMY8W%PMW%D@KW)Gbf   -/(=ZZKM8[
2(N8YXWK85@K   -'c|K4/KKK%@  V%@@WD8e~  .//ct)8ZK%8` 2(N8YXWK85@K   -'c|K4/KKK%@  V%@@WD8e~  .//ct)8ZK%8`
=)b%]Nd)@KM[  !'\cG!iWYK%%|   !M@KZf    -c\))ZDKW%`  =)b%]Nd)@KM[  !'\cG!iWYK%%|   !M@KZf    -c\))ZDKW%`
YYKWZGNM4/Pb  '-VscP4]b@W%     'Mf`   -L\///KM(%W!   YYKWZGNM4/Pb  '-VscP4]b@W%     'Mf`   -L\///KM(%W!
!KKW4ZK/W7)Z. '/cttbY)DKW%     -`  .',\v)K(5KW%%f    !KKW4ZK/W7)Z. '/cttbY)DKW%     -`  .',\v)K(5KW%%f
'W)KWKZZg)Z2/,!/L(-DYYb54%  ,,`, -\-/v(((KK5WW%f     'W)KWKZZg)Z2/,!/L(-DYYb54%  ,,`, -\-/v(((KK5WW%f
 \M4NDDKZZ(e!/\7vNTtZd)8\Mi!\-,-/i-v((tKNGN%W%%       \M4NDDKZZ(e!/\7vNTtZd)8\Mi!\-,-/i-v((tKNGN%W%%
 'M8M88(Zd))///((|D\tDY\\KK-`/-i(=)KtNNN@W%%%@%[      'M8M88(Zd))///((|D\tDY\\KK-`/-i(=)KtNNN@W%%%@%[
  !8%@KW5KKN4///s(\Pd!ROBY8/=2(/4ZdzKD%K%%%M8@%%       !8%@KW5KKN4///s(\Pd!ROBY8/=2(/4ZdzKD%K%%%M8@%%
   '%%%W%dGNtPK(c\/2\[Z(ttNYZ2NZW8W8K%%%%YKM%M%%.       '%%%W%dGNtPK(c\/2\[Z(ttNYZ2NZW8W8K%%%%YKM%M%%.
     *%%W%GW5@/%!e]_tZdY()v)ZXMZW%W%%%*5Y]K%ZK%8[         *%%W%GW5@/%!e]_tZdY()v)ZXMZW%W%%%*5Y]K%ZK%8[
      '*%%%%8%8WK\)[/ZmZ/Zi]!/M%%%%@f\ \Y/NNMK%%!          '*%%%%8%8WK\)[/ZmZ/Zi]!/M%%%%@f\ \Y/NNMK%%!
        'VM%%%%W%WN5Z/Gt5/b)((cV@f`  - |cZbMKW%%|            'VM%%%%W%WN5Z/Gt5/b)((cV@f`  - |cZbMKW%%|
           'V*M%%%WZ/ZG\t5((+)L\'-,,/  -)X(NWW%%                'V*M%%%WZ/ZG\t5((+)L\'-,,/  -)X(NWW%%
                `~`MZ/DZGNZG5(((\,    ,t\\Z)KW%@                     `~`MZ/DZGNZG5(((\,    ,t\\Z)KW%@
                   'M8K%8GN8\5(5///]i!v\K)85W%%f                        'M8K%8GN8\5(5///]i!v\K)85W%%f
                     YWWKKKKWZ8G54X/GGMeK@WM8%@                           YWWKKKKWZ8G54X/GGMeK@WM8%@
                      !M8%8%48WG@KWYbW%WWW%%%@                             !M8%8%48WG@KWYbW%WWW%%%@
                        VM%WKWK%8K%%8WWWW%%%@`                               VM%WKWK%8K%%8WWWW%%%@`
                          ~*%%%%%%W%%%%%%%@~                                   ~*%%%%%%W%%%%%%%@~
                             ~*MM%%%%%%@f`                                        ~*MM%%%%%%@f`
                                  '''''                                                '''''

                   ___   __  _______________   ______  ____  __    _________   __________
                  /   | / / / / ____/ ____/ | / / __ \/ __ \/ /   /  _/__  /  / ____/  _/
                 / /| |/ / / / / __/ __/ /  |/ / /_/ / / / / /    / /   / /  / __/  / /
                / ___ / /_/ / /_/ / /___/ /|  / ____/ /_/ / /____/ /   / /__/ /____/ /
               /_/  |_\____/\____/_____/_/ |_/_/    \____/_____/___/  /____/_____/___/

                  _A                                _A                                 _A
                .'`"`'.                           .'`"`'.                            .'`"`'.
               /   , , \                         /   , , \                          /   , , \
              |   <\^/> |                       |   <\^/> |                        |   <\^/> |
              |  < (_) >|                       |  < (_) >|                        |  < (_) >|
              /====\                            /====\                             /====\
             (.--._ _.--.)                     (.--._ _.--.)                      (.--._ _.--.)
              |\  -`\- /|                       |\  -`\- /|                        |\  -`\- /|
              |(_.- >-.)|                       |(_.- >-.)|                        |(_.- >-.)|
              \__.-'^'._/                       \__.-'^'._/                        \__.-'^'._/
               |\   .  /                         |\   .  /                          |\   .  /
            _.'\ '----'|'-.                   _.'\ '----'|'-.                    _.'\ '----'|'-.
        _.-'  O ;-.__.' \O `o.            _.-'  O ;-.__.' \O `o.             _.-'  O ;-.__.' \O `o.
       /o \      \/-.-\/|     \          /o \      \/-.-\/|     \           /o \      \/-.-\/|     \
   jgs|    ;,     '.|\| /            jgs|    ;,     '.|\| /             jgs|    ;,     '.|\| /
EOF
)"

pause="$((60 * 15))"
timeout='15'
button='GENAU'

while :; do
    xmessage -buttons "$button" -default "$button" -timeout "$timeout" "$augenpolizei"
    sleep "$pause"
done
