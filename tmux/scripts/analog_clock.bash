#!/usr/bin/env bash
# Print an analog clock using emoji in a tmux status bar.

exit

# http://stackoverflow.com/q/5437674/4694621
case "$(date -j +'%I%M')" in
    01[0-2]?) clock='\U1F550' ;; # CLOCK FACE ONE OCLOCK
    01[3-5]?) clock='\U1F55C' ;; # CLOCK FACE ONE-THIRTY
    02[0-2]?) clock='\U1F551' ;; # CLOCK FACE TWO OCLOCK
    02[3-5]?) clock='\U1F55D' ;; # CLOCK FACE TWO-THIRTY
    03[0-2]?) clock='\U1F552' ;; # CLOCK FACE THREE OCLOCK
    03[3-5]?) clock='\U1F55E' ;; # CLOCK FACE THREE-THIRTY
    04[0-2]?) clock='\U1F553' ;; # CLOCK FACE FOUR OCLOCK
    04[3-5]?) clock='\U1F55F' ;; # CLOCK FACE FOUR-THIRTY
    05[0-2]?) clock='\U1F554' ;; # CLOCK FACE FIVE OCLOCK
    05[3-5]?) clock='\U1F560' ;; # CLOCK FACE FIVE-THIRTY
    06[0-2]?) clock='\U1F555' ;; # CLOCK FACE SIX OCLOCK
    06[3-5]?) clock='\U1F561' ;; # CLOCK FACE SIX-THIRTY
    07[0-2]?) clock='\U1F556' ;; # CLOCK FACE SEVEN OCLOCK
    07[3-5]?) clock='\U1F562' ;; # CLOCK FACE SEVEN-THIRTY
    08[0-2]?) clock='\U1F557' ;; # CLOCK FACE EIGHT OCLOCK
    08[3-5]?) clock='\U1F563' ;; # CLOCK FACE EIGHT-THIRTY
    09[0-2]?) clock='\U1F558' ;; # CLOCK FACE NINE OCLOCK
    09[3-5]?) clock='\U1F564' ;; # CLOCK FACE NINE-THIRTY
    10[0-2]?) clock='\U1F559' ;; # CLOCK FACE TEN OCLOCK
    10[3-5]?) clock='\U1F565' ;; # CLOCK FACE TEN-THIRTY
    11[0-2]?) clock='\U1F55A' ;; # CLOCK FACE ELEVEN OCLOCK
    11[3-5]?) clock='\U1F566' ;; # CLOCK FACE ELEVEN-THIRTY
    12[0-2]?) clock='\U1F55B' ;; # CLOCK FACE TWELVE OCLOCK
    12[3-5]?) clock='\U1F567' ;; # CLOCK FACE TWELVE-THIRTY
esac


# http://www.fileformat.info/info/unicode/block/geometric_shapes/list.htm
# clock+=' '
# case "$(date -j +'%M')" in
#     0?|1[0-4]) clock+='\U25D4' ;;
#     1[5-9]|2?) clock+='\U25D1' ;;
#     3?|4[0-4]) clock+='\U25D5' ;;
#     4[5-9]|5?) clock+='\U25CF' ;;
# esac

echo -e "$clock"
