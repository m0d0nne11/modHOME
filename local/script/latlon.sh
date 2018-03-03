# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash

# Example: latlon.sh 42.85 -71.8850

echo 'http://maps.google.com/maps?saddr='$1','$2

