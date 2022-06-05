#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Illegal number of parameters"
  exit 1
fi

linesCovered=0
linesValid=0
for CoberturaPath in "$@"
do
  if [ ! -f "$CoberturaPath" ]; then
    echo "File $CoberturaPath is not exits."
    exit 1
  fi
  Coverage=$(grep "<coverage " $CoberturaPath)

  LineRate=$(echo $Coverage | sed -E 's/.*line-rate=\"([0-9]+(.[0-9]+)?)\".*/\1/')
  linesCovered=$(( $(echo $Coverage | sed -E 's/.*lines-covered=\"([0-9]+(.[0-9]+)?)\".*/\1/') + $linesCovered ))
  linesValid=$(( $(echo $Coverage | sed -E 's/.*lines-valid=\"([0-9]+(.[0-9]+)?)\".*/\1/') + $linesValid ))
done

echo "LineCoverage: $linesCovered / $linesValid"
LineRatePercent=$(awk '{print $1/$2*100}' <<< "$linesCovered $linesValid")
echo "LineRate: $LineRatePercent%"


