#!/bin/bash
set -e

# Input files
INPUT="/d/Fun/Steam/steamapps/common/Endless Sky/data/map planets.txt"
TEMPLATE1="./template1.j2"    # Mission file header or shared content
TEMPLATE2="./template2.j2"    # Job board mission (spaceport available)
TEMPLATE3="./template3.j2"    # Landing mission (no spaceport)
OUTPUT_FILE="../data/missions.txt"

# Temp file
TMP_FILE="${OUTPUT_FILE}.tmp"

# Start output with shared template
cat "$TEMPLATE1" > "$TMP_FILE"

# State tracking
inside_planet=0
planet_name=""
has_outfitter=0
has_spaceport=0

while IFS= read -r line; do
    if [[ $line == planet\ * ]]; then
        # Finish previous block if valid
        if [[ $inside_planet -eq 1 && $has_outfitter -eq 0 && -n $planet_name ]]; then
            if [[ $has_spaceport -eq 1 ]]; then
                sed "s/{{ *origin * }}/$planet_name/g" "$TEMPLATE2" >> "$TMP_FILE"
            else
                sed "s/{{ *origin * }}/$planet_name/g" "$TEMPLATE3" >> "$TMP_FILE"
            fi
            echo "" >> "$TMP_FILE"
        fi

        inside_planet=1
        has_outfitter=0
        has_spaceport=0

        # Extract planet name (remove surrounding quotes if present)
        planet_name="${line#planet }"
        planet_name="${planet_name%\"}"
        planet_name="${planet_name#\"}"
        continue
    fi

    # Detect outfitter or spaceport in planet block
    if [[ "$line" =~ outfitter ]]; then
        has_outfitter=1
    elif [[ "$line" =~ spaceport ]]; then
        has_spaceport=1
    fi
done < "$INPUT"

# Handle final planet block
if [[ $inside_planet -eq 1 && $has_outfitter -eq 0 && -n $planet_name ]]; then
    if [[ $has_spaceport -eq 1 ]]; then
        sed "s/{{ *origin * }}/$planet_name/g" "$TEMPLATE2" >> "$TMP_FILE"
    else
        sed "s/{{ *origin * }}/$planet_name/g" "$TEMPLATE3" >> "$TMP_FILE"
    fi
    echo "" >> "$TMP_FILE"
fi

# Finalize output
mv "$TMP_FILE" "$OUTPUT_FILE"
echo "✔ Missions written to $OUTPUT_FILE"
